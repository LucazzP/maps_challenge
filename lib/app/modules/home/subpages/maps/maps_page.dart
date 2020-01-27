import 'package:flutter/material.dart';
import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/subpages/maps/maps_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  final String title;
  const MapsPage({Key key, this.title = "Maps"}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final HomeBloc homeBloc = HomeModule.to.get<HomeBloc>();
  final MapsBloc bloc = HomeModule.to.get<MapsBloc>();

  final CameraPosition _jardimBotanico = CameraPosition(
    target: LatLng(-25.4420757, -49.2466702),
    zoom: 15.4,
  );

  @override
  void initState() {
    homeBloc.updateLastLocation(_jardimBotanico.target.latitude, _jardimBotanico.target.longitude);
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
