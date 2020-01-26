import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_details/place_details_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Disposable {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  BehaviorSubject<int> activePage = BehaviorSubject<int>.seeded(1);
  PageController pageController = PageController(initialPage: 1);
  double lastLat;
  double lastLng;

  HomeBloc(){
    pageController.addListener(() => activePage.sink.add(pageController.page.toInt()));
  }

  void updateLastLocation(double lat, double lng){
    lastLat = lat;
    lastLng = lng;
  }

  void openDetailsPlace(SpotModel spot) {
    print("Click on " + spot.documentReference.documentID);
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
  void dispose() {
    activePage.close();
  }
}
