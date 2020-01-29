import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_details_bottom_sheet/place_details_bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Disposable {
  PersistentBottomSheetController bottomSheetController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final BehaviorSubject<int> activePage = BehaviorSubject<int>.seeded(1);
  final PageController pageController = PageController(initialPage: 1);
  GoogleMapController mapController;
  double lastLat;
  double lastLng;

  HomeBloc() {
    pageController
        .addListener(() => activePage.sink.add(pageController.page.toInt()));
  }

  Future<void> changePage(int page) async {
    closeAll();
    await Future.delayed(Duration(milliseconds: 200));
    pageController.jumpToPage(page);
  }

  void updateLastLocation(double lat, double lng) {
    lastLat = lat;
    lastLng = lng;
  }

  void openDetailsPlace(SpotModel spot) {
    bottomSheetController = scaffoldKey.currentState.showBottomSheet(
      (context) {
        return PlaceDetailsBottomSheetWidget(
          place: spot,
          onTap: () => _openDetailsPlaceModal(spot),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.transparent,
    );
  }

  void _openDetailsPlaceModal(SpotModel spot) {
    bottomSheetController.close();
    showModalBottomSheet(
      context: scaffoldKey.currentState.context,
      builder: (context) {
        return PlaceDetailsBottomSheetWidget(
          place: spot,
          expanded: true,
        );
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.transparent,
    );
  }

  void closeAll() {
    try {
      if (bottomSheetController != null) {
        bottomSheetController.close();
        bottomSheetController = null;
      }
    } catch (e) {}
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    activePage.close();
  }
}
