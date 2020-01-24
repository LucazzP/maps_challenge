import 'dart:async';

import 'package:desafio_maps/app/modules/home/widgets/search/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _jardimBotanico = CameraPosition(
    target: LatLng(-25.4420757, -49.2466702),
    zoom: 15.4,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _jardimBotanico,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      bottomNavigationBar: _bottomNavigator,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(double.maxFinite),
        child: SearchWidget(),
      ),
    );
  }

  final Widget _bottomNavigator = BottomNavigationBar(
    items: [
      const BottomNavigationBarItem(
        icon: const Icon(Icons.star),
        title: const SizedBox(),
      ),
      const BottomNavigationBarItem(
        icon: const Icon(Icons.location_on),
        title: const SizedBox(),
      ),
      const BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: const SizedBox(),
      ),
    ],
  );
}
