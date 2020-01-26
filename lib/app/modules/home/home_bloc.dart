import 'package:desafio_maps/app/modules/home/widgets/place_details/place_details_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeBloc extends Disposable {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double lastLat;
  double lastLng;

  void updateLastLocation(double lat, double lng){
    lastLat = lat;
    lastLng = lng;
  }

  void openDetailsPlace(String placeId) {
    print("Click on " + placeId);
    scaffoldKey.currentState.showBottomSheet(
      (context){
        return PlaceDetailsWidget();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      backgroundColor: Colors.transparent
    );
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
