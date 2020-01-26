import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapsBloc extends Disposable {
  HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  HomeBloc bloc = HomeModule.to.get<HomeBloc>();
  BehaviorSubject<Set<Marker>> markers =
      BehaviorSubject<Set<Marker>>.seeded(Set<Marker>());

  Future<void> getNearbyPlaces(double lat, double lng) async {
    // NOTE Verify if the last request have more than 1000 meters from the future request 
    if (markers.value.isEmpty || (await Geolocator()
            .distanceBetween(bloc.lastLat, bloc.lastLng, lat, lng)) >
        1000) {
      bloc.updateLastLocation(lat, lng);
      List<SpotModel> spots = await _repo.getSpotsNearby(lat, lng);
      addAllMarkers(
        spots.map((spot) =>
          Marker(
            markerId: MarkerId(spot.documentReference.documentID),
            onTap: () => bloc.openDetailsPlace(spot),
            position: LatLng(spot.lat, spot.lng),
            infoWindow: InfoWindow(
              title: spot.name,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(spot.iconColor),
          )
        ).toSet()
      );
    }
  }

  void addAllMarkers(Set<Marker> _markers) {
    Set<Marker> list = markers.value;
    list.addAll(_markers);
    markers.sink.add(list);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    markers.close();
  }
}
