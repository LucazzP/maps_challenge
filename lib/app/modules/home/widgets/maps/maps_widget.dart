import 'dart:async';

import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/widgets/maps/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({Key key}) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final Function(double lat, double lng) updateLastLocation =
      HomeModule.to.get<HomeBloc>().updateLastLocation;
  final MapsBloc bloc = HomeModule.to.get<MapsBloc>();

  final CameraPosition _jardimBotanico = CameraPosition(
    target: LatLng(-25.4420757, -49.2466702),
    zoom: 15.4,
  );

  @override
  void initState() {
    updateLastLocation(_jardimBotanico.target.latitude, _jardimBotanico.target.longitude);
    bloc.getNearbyPlaces(_jardimBotanico.target.latitude, _jardimBotanico.target.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Set<Marker>>(
      stream: bloc.markers.stream,
      builder: (context, markers) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _jardimBotanico,
          markers: markers.hasData ? markers.data : <Marker>[].toSet(),
          onCameraMove: (CameraPosition position){
            bloc.getNearbyPlaces(position.target.latitude, position.target.longitude);
          },
        );
      }
    );
  }
}
