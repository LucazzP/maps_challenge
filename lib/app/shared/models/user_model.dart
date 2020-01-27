import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/shared/extensions.dart';

class UserModel {
  final List<SpotModel> registredSpots;
  final List<SpotModel> favorites;
  final DocumentReference documentReference;

  UserModel({this.registredSpots, this.favorites, this.documentReference});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    registredSpots: json['registredSpots'] == null ? null : List.from(json['registredSpots']).map((spot) => SpotModel.fromJson(spot)),
    favorites: json['favorites'] == null ? null : List.from(json['favorites']).map((spot) => SpotModel.fromJson(spot)),
  );

  static Future<UserModel> fromDocument(DocumentSnapshot document) async {
    if(!document.exists || document.data.isEmpty || document.data == null) return UserModel(
      documentReference: document.reference,
      registredSpots: <SpotModel>[],
      favorites: <SpotModel>[],
    ); 

    final _listRefsRegistred = document.data['registredSpots'] == null ? null : List.castFrom<dynamic, DocumentReference>(document.data['registredSpots']);
    List<SpotModel> _registredSpots = await FuturePlus.forEachFuture<DocumentReference, SpotModel>(_listRefsRegistred, (ref) => SpotModel.fromReference(ref));

    final _listRefsFavorites = document.data['favorites'] == null ? null : List.castFrom<dynamic, DocumentReference>(document.data['favorites']);
    List<SpotModel> _favorites = await FuturePlus.forEachFuture<DocumentReference, SpotModel>(_listRefsFavorites, (ref) => SpotModel.fromReference(ref));

    return UserModel(
      registredSpots: await _registredSpots,
      favorites: await _favorites,
      documentReference: document.reference
    );
  }

  Map<String, dynamic> toJson() => {
    "registredSpots": registredSpots == null ? [] : registredSpots.map((spot) => spot.documentReference).toList(),
    "favorites": favorites == null ? [] : favorites.map((spot) => spot.documentReference).toList(),
  };
}