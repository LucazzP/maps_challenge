import 'dart:io';

import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/shared/widgets/alert_dialog/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tinycolor/tinycolor.dart';

class NewSpotBottomSheetBloc extends Disposable {
  final HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<File> photo = BehaviorSubject<File>();
  final BehaviorSubject<Color> color = BehaviorSubject<Color>();
  final BehaviorSubject<String> location = BehaviorSubject<String>();
  final BehaviorSubject<String> error = BehaviorSubject<String>();
  List<String> _sugestions = ["Park", "Museum", "Theater", "Monument"];
  String name;
  String category;
  Place locationPlace;
  String about;
  String description;

  NewSpotBottomSheetBloc(){
    _repo.getCategories.then((data) => _sugestions = data);
  }

  Future<bool> addSpot(BuildContext context) async {
    if (_validate) {
      try {
        // Upload photo
        String _photo = await _uploadPhoto(photo.value, context);
        
        // Update categories on Db
        if(!_sugestions.contains(category)){
          _repo.postNewCategory(category);
        }

        // Post the spot
        await _repo.postNewSpot(
          SpotModel(
            iconColor: TinyColor(color.value).toHsv().hue,
            name: name,
            category: category,
            lat: locationPlace.latitude,
            lng: locationPlace.longitude,
            rating: 0,
            photo: _photo,
            about: about,
            description: description,
          ),
        );
        return true;
      } catch (e) {}
    }
    return false;
  }

  Future<String> _uploadPhoto(File file, BuildContext context) {
    Sink<double> _sink;
    AlertDialogCustom.progressBar(context, onCreated: (sink) => _sink = sink);
    return _repo.uploadPhoto(file, sinkProgress: _sink);
  }

  bool get _validate {
    if (formKey.currentState.validate()) {
      if (photo.hasValue) {
        if (name != null && name.isNotEmpty) {
          if (category != null && category.isNotEmpty) {
            if (locationPlace != null && location.hasValue) {
              if (color.hasValue) {
                if (about != null && about.isNotEmpty) {
                  if (description != null && description.isNotEmpty) {
                    if (error.hasValue) error.sink.add(null);
                    return true;
                  } else
                    error.sink.add("Describe the spot on the field decription!");
                } else
                  error.sink.add("Describe the spot on the field about!");
              } else
                error.sink.add("Add a color to the spot!");
            } else
              error.sink.add("Add a location to the spot!");
          } else
            error.sink.add("Add a category to the spot!");
        } else
          error.sink.add("Add a name to the spot!");
      } else
        error.sink.add("Add a photo to the spot!");
    }
    return false;
  }

  Future get getLocation async {
    try {
      Place place = await PluginGooglePlacePicker.showAutocomplete(
          countryCode: "BR", mode: PlaceAutocompleteMode.MODE_OVERLAY);
      locationPlace = place;
      String _location =
          (await _repo.getPlaceDetails(place.id)).data['result']['vicinity'];
      location.sink.add(_location);
    } catch (e) {
      error.sink.add(e);
      location.sink.addError(e);
    }
  }

  List<String> sugestions(String input){
    return input == null ? _sugestions : _sugestions.where((value) => value.toLowerCase().contains(input.toLowerCase())).toList();
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
