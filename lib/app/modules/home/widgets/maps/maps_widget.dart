import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
  final Function(double lat, double lng) updateLastLocation;

  const MapsWidget(this.updateLastLocation, {Key key}) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _jardimBotanico = CameraPosition(
    target: LatLng(-25.4420757, -49.2466702),
    zoom: 15.4,
  );

  @override
  void initState() {
    widget.updateLastLocation(_jardimBotanico.target.latitude, _jardimBotanico.target.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _jardimBotanico,
      markers: <Marker>[
        Marker(
          position: LatLng(-25.4420757, -49.2466702),
          markerId: MarkerId('Jardim'),
          onTap: () {
            print("Oi");
          },
        )
      ].toSet(),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onCameraMove: (CameraPosition position){
        widget.updateLastLocation(position.target.latitude, position.target.longitude);
      },
    );
  }
}
