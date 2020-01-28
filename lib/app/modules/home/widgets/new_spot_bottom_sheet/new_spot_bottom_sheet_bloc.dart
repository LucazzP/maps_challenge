import 'dart:io';

import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:rxdart/rxdart.dart';

class NewSpotBottomSheetBloc extends Disposable {
  final HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<File> photo = BehaviorSubject<File>();
  final BehaviorSubject<Color> color = BehaviorSubject<Color>();
  final BehaviorSubject<String> location = BehaviorSubject<String>();
  String name;
  String category;

  Future<bool> get addSpot async {
    return false;
  }

  Future get getLocation async {
    try {
      Place place = await PluginGooglePlacePicker.showAutocomplete(
          countryCode: "BR", mode: PlaceAutocompleteMode.MODE_OVERLAY);
      String _location =
          (await _repo.getPlaceDetails(place.id)).data['result']['vicinity'];
      location.sink.add(_location);
    } catch (e) {
      location.sink.addError(e);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
