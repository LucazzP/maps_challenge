import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/modules/home/models/comment_model.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/shared/models/response_model.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:desafio_maps/app/shared/repositories/dio_requests.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Maps;
import 'package:maps_toolkit/maps_toolkit.dart';
import 'dart:math' as Math;

class HomeRepository extends Disposable {
  final DioRequests dioRequests;
  String apiKeyGoogle;

  HomeRepository(
    Dio dio, {
    this.apiKeyGoogle,
  }) : dioRequests = DioRequests(dio);

  final String baseUrlGoogle = "https://maps.googleapis.com/maps/api/place";

  Future<List<SpotModel>> getSpotsSearch(String input) async {
    QuerySnapshot query = await Firestore.instance
        .collection("spots")
        .where("name", isGreaterThanOrEqualTo: input)
        .limit(4)
        .getDocuments();
    return query.documents.map((doc) => SpotModel.fromDocument(doc)).toList();
  }

  Maps.LatLngBounds _getLatLngBoundsFromCenter(
      double lat, double lng, int radius) {
    double distanceFromCenterToCorner = radius * Math.sqrt(2.0);
    LatLng southwestCorner = SphericalUtil.computeOffset(
        LatLng(lat, lng), distanceFromCenterToCorner, 225.0);
    LatLng northeastCorner = SphericalUtil.computeOffset(
        LatLng(lat, lng), distanceFromCenterToCorner, 45.0);
    return Maps.LatLngBounds(
        southwest:
            Maps.LatLng(southwestCorner.latitude, southwestCorner.longitude),
        northeast:
            Maps.LatLng(northeastCorner.latitude, northeastCorner.longitude));
  }

  Future<List<SpotModel>> getSpotsNearby(double lat, double lng) async {
    List<DocumentSnapshot> results = List<DocumentSnapshot>();

    //NOTE Calculate the radius and make the request
    Maps.LatLngBounds bounds = _getLatLngBoundsFromCenter(lat, lng, 5000);

    Query query = Firestore.instance.collection("spots");
    query
        .where(
          "lat",
          isGreaterThanOrEqualTo: bounds.southwest.latitude,
          isLessThanOrEqualTo: bounds.northeast.latitude,
        )
        .getDocuments()
        .then(
          (docs) => results.addAll(docs.documents),
        );
    if (bounds.southwest.longitude <= bounds.northeast.longitude) {
      results = (await query
              .where(
                "lng",
                isGreaterThanOrEqualTo: bounds.southwest.longitude,
                isLessThanOrEqualTo: bounds.northeast.longitude,
              )
              .getDocuments())
          .documents;
    } else {
      results = (await query
              .where(
                "lng",
                isGreaterThanOrEqualTo: bounds.southwest.longitude,
              )
              .getDocuments())
          ?.documents;
      results.addAll((await query
              .where(
                "lng",
                isLessThanOrEqualTo: bounds.northeast.longitude,
              )
              .getDocuments())
          .documents);
    }

    results = results
        .where((result) => bounds
            .contains(Maps.LatLng(result.data['lat'], result.data['lng'])))
        .toList();

    return results.map((doc) => SpotModel.fromDocument(doc)).toList();
  }

  Future favoritePlace(DocumentReference place, UserModel user) {
    List<DocumentReference> favorites =
        user.favorites.map((fav) => fav.documentReference).toList();
    if(favorites.contains(place)){
      favorites.remove(place);
    } else {
      favorites.add(place);
    }  
    return user.documentReference.updateData({
      "favorites": favorites,
    });
  }

  Future postNewComment(CommentModel comment, DocumentReference place){
    return Firestore.instance.runTransaction((transaction) async {
      final snap = await transaction.get(place);
      Map<String, dynamic> freshPlace = snap.data;
      List<Map> comments = List.from(freshPlace['comments']);
      comments.add(comment.toJson());
      freshPlace['comments'] = comments;

      double newRating = comments.map<int>((c) => c['rating']).reduce((a, b) => a + b) / comments.length;
      freshPlace['rating'] = newRating;

      transaction.update(place, freshPlace);
    });
  }

  Stream<SpotModel> streamPlace(DocumentReference place){
    return place.snapshots().map((doc) => SpotModel.fromDocument(doc));
  }

  Future<ResponseModel<Map<String, dynamic>>> getPlaceAutoComplete(String input,
      {String sessionId, String lat, String lng}) {
    return dioRequests.get<Map<String, dynamic>>(
      "$baseUrlGoogle/autocomplete/json?"
      "input=$input"
      "&location=$lat,$lng"
      "&key=$apiKeyGoogle"
      "&sessiontoken=$sessionId"
      "&language=pt-BR",
    );
  }

  Future<ResponseModel<Map<String, dynamic>>> getPlacesNearby(
          String lat, String lng,
          {String pageToken}) =>
      dioRequests.get<Map<String, dynamic>>(
        "$baseUrlGoogle/nearbysearch/json?"
        "location=$lat,$lng"
        "&type=tourist_attraction"
        "&key=$apiKeyGoogle"
        "&radius=5000"
        "&language=pt-BR"
        "${pageToken == null ? "" : "&pagetoken=$pageToken"}",
      );

  Future<ResponseModel> getPhoto(String photoReference, {int maxWidth = 400}) =>
      dioRequests.get(
        "$baseUrlGoogle/photo?"
        "maxwidth=${maxWidth.toString()}"
        "&photoreference=$photoReference"
        "&key=$apiKeyGoogle",
      );

  Future<ResponseModel<Map<String, dynamic>>> getPlaceDetails(String placeId,
          {String sessionId}) =>
      dioRequests.get<Map<String, dynamic>>(
        "$baseUrlGoogle/details/json?"
        "place_id=$placeId"
        "&sessiontoken=$sessionId"
        "&fields=vicinity"
        "&key=$apiKeyGoogle"
        "&language=pt-BR",
      );

  //dispose will be called automatically
  @override
  void dispose() {}
}
