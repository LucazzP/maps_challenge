import 'dart:async';

import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Disposable {
  HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  HomeBloc homeBloc = HomeModule.to.get<HomeBloc>();

  BehaviorSubject<bool> expanded = BehaviorSubject<bool>();

  BehaviorSubject<List<PlaceTileModel>> _listResults =
      BehaviorSubject<List<PlaceTileModel>>();

  List<PlaceTileModel> get listResults => _listResults.value;

  set listResults(List<PlaceTileModel> newListResults) {
    if (listResults != newListResults) _listResults.sink.add(newListResults);
  }

  Stream<List<PlaceTileModel>> get listResultsOut => _listResults.stream;

  Timer _timer;

  void expand(bool expand) {
    if (expand != expanded.value) {
      if(expand) homeBloc.closeAll();
      expanded.sink.add(expand);
    }
  }

  void updateResults(String query) {
    if (query.isNotEmpty) {
     if (_timer == null || !(_timer?.isActive ?? false)) {
       _queryResults(query);
     }
      _cancelTimer();
      _timer = Timer(Duration(milliseconds: 600), () {
        _queryResults(query);
      });
    } else {
      _resetResults();
    }
  }

  Future<void> _queryResults(String query) async {
    final List<SpotModel> response = await _repo.getSpotsSearch(query);
    listResults = response.map((spot) => PlaceTileModel(title: spot.name, subtitle: spot.description, photo: spot.photo, placeId: spot.documentReference.documentID, position: LatLng(spot.lat, spot.lng))).toList();
  }

  void _cancelTimer() {
    if (_timer != null && (_timer?.isActive ?? false)) _timer.cancel();
  }

  void _resetResults() {
    _cancelTimer();
    listResults = null;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    expanded.close();
    _listResults.close();
  }
}
