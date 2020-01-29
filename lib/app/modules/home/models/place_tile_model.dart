import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceTileModel {
  final String title;
  final String subtitle;
  final String photo;
  final String placeId;
  final LatLng position;

  PlaceTileModel({
    this.title,
    this.subtitle,
    this.photo,
    this.placeId,
    this.position,
  });
}
