import 'dart:async';

import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:desafio_maps/app/shared/models/response_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class SearchBloc extends Disposable {
  HomeRepository _repo = HomeModule.to.get<HomeRepository>();

  BehaviorSubject<bool> expanded = BehaviorSubject<bool>();

  BehaviorSubject<List<PlaceTileModel>> _listResults =
      BehaviorSubject<List<PlaceTileModel>>();

  List<PlaceTileModel> get listResults => _listResults.value;

  set listResults(List<PlaceTileModel> newListResults) {
    if (listResults != newListResults) _listResults.sink.add(newListResults);
  }

  Stream<List<PlaceTileModel>> get listResultsOut => _listResults.stream;

  Timer _timer;
  String _sessionId = Uuid().v4();
  double _lastLat;
  double _lastLng;

  void expand(bool expand) {
    if (expand != expanded.value) expanded.sink.add(expand);
  }

  void updateLastLocation(double lat, double lng){
    _lastLat = lat;
    _lastLng = lng;
  }

  void updateResults(String query) {
    if (query.isNotEmpty) {
//      if (_timer == null || !(_timer?.isActive ?? false)) {
//        _queryResults(query);
//      }
      _cancelTimer();
      _timer = Timer(Duration(milliseconds: 1500), () {
        _queryResults(query);
      });
    } else {
      _resetResults();
    }
  }

  Future<void> _queryResults(String query) async {
    final ResponseModel<Map<String, dynamic>> response = await _repo.getPlaceAutoComplete(
      query,
      sessionId: _sessionId,
      lat: _lastLat.toString(),
      lng: _lastLng.toString()
    );
    listResults = List.castFrom<dynamic, Map<String, dynamic>>(response.data['predictions']).map((json) => PlaceTileModel.fromResult(json)).toList();
  }

  void _cancelTimer() {
    if (_timer != null && (_timer?.isActive ?? false)) _timer.cancel();
  }

  void resetSessionId() => _sessionId = Uuid().v4();

  void _resetResults() {
    _cancelTimer();
    resetSessionId();
    listResults = null;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    expanded.close();
    _listResults.close();
  }
}
