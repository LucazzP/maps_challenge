import 'dart:io';
import 'dart:math' as Math;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/modules/home/models/comment_model.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/shared/extensions.dart';
import 'package:desafio_maps/app/shared/models/response_model.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:desafio_maps/app/shared/repositories/dio_requests.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Maps;
import 'package:maps_toolkit/maps_toolkit.dart';

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
        .where("name", isGreaterThanOrEqualTo: input.capitalise())
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
    if (favorites.contains(place)) {
      favorites.remove(place);
    } else {
      favorites.add(place);
    }
    return user.documentReference.updateData({
      "favorites": favorites,
    });
  }

  Future postNewComment(CommentModel comment, DocumentReference place) {
    return Firestore.instance.runTransaction((transaction) async {
      final snap = await transaction.get(place);
      Map<String, dynamic> freshPlace = snap.data;
      List<Map> comments = List.from(freshPlace['comments']);
      comments.add(comment.toJson());
      freshPlace['comments'] = comments;

      double newRating =
          comments.map<int>((c) => c['rating']).reduce((a, b) => a + b) /
              comments.length;
      freshPlace['rating'] = newRating;

      transaction.update(place, freshPlace);
    });
  }

  Stream<SpotModel> streamPlace(DocumentReference place) {
    return place.snapshots().map((doc) => SpotModel.fromDocument(doc));
  }

  Future postNewSpot(SpotModel spot) {
    return Firestore.instance.collection("spots").add(spot.toJson());
  }

  Future<String> uploadPhoto(File file, {Sink<double> sinkProgress}) async {
    final StorageReference storageRef = FirebaseStorage.instance
        .ref()
        .child('photos/${DateTime.now().microsecondsSinceEpoch}');
    final File compressedImage = await FlutterImageCompress.compressAndGetFile(file.absolute.path, file.absolute.path + '_compressed.jpg', quality: 80);
    final StorageUploadTask uploadTask = storageRef.putFile(
      compressedImage,
      StorageMetadata(contentType: 'image'),
    );

    if (sinkProgress != null) {
      uploadTask.events.listen((task) {
        sinkProgress
            .add(task.snapshot.bytesTransferred / task.snapshot.totalByteCount);
      });
    }

    final ref = (await uploadTask.onComplete).ref;
    final String url = await ref.getDownloadURL();

    return url;
  }

  Future<List<String>> get getCategories async {
    return List.castFrom<dynamic, String>(
      (await Firestore.instance
              .collection("suggestions")
              .document("categories")
              .get())
          .data['categories'],
    );
  }

  Future postNewCategory(String category) {
    DocumentReference categories =
        Firestore.instance.collection("suggestions").document("categories");
    return Firestore.instance.runTransaction((transaction) async {
      final List<String> freshCategories =
          List.castFrom<dynamic, String>((await transaction.get(categories)).data['categories']);
      List<String> newList = List.from(freshCategories);
      if (!freshCategories.contains(category)) {
        newList.add(category);
      }
      categories.updateData({"categories": newList});
    });
  }

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
