import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_details/place_details_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Disposable {
  PersistentBottomSheetController bottomSheetController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final BehaviorSubject<int> activePage = BehaviorSubject<int>.seeded(1);
  final PageController pageController = PageController(initialPage: 1);
  double lastLat;
  double lastLng;

  HomeBloc() {
    pageController
        .addListener(() => activePage.sink.add(pageController.page.toInt()));
  }

  Future<void> changePage(int page) async {
    if(bottomSheetController != null){
      bottomSheetController.close();
      await Future.delayed(Duration(milliseconds: 200));
      bottomSheetController = null;
    }

    pageController.animateToPage(page,
          curve: Curves.decelerate, duration: Duration(milliseconds: 200),);
  }

  void updateLastLocation(double lat, double lng) {
    lastLat = lat;
    lastLng = lng;
  }

  void openDetailsPlace(SpotModel spot) {
    print("Click on " + spot.documentReference.documentID);
    bottomSheetController = scaffoldKey.currentState.showBottomSheet((context) {
      return PlaceDetailsWidget(
        place: spot,
      );
    },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.transparent);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    activePage.close();
  }
}
