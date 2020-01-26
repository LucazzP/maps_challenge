import 'dart:io';

import 'package:desafio_maps/app/shared/models/response_model.dart';
import 'package:desafio_maps/app/shared/repositories/dio_requests.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class HomeRepository extends Disposable {
  final Dio dio;
  final DioRequests dioRequests;
  String _apiKeyGoogle;

  HomeRepository(
    this.dio, {
    String apiKeyGoogleIos,
    String apiKeyGoogleAndroid,
  }) : dioRequests = DioRequests(dio) {
    if (Platform.isIOS) _apiKeyGoogle = apiKeyGoogleIos;
    if (Platform.isAndroid) _apiKeyGoogle = apiKeyGoogleAndroid;
  }

  final String baseUrlGoogle = "https://maps.googleapis.com/maps/api/place";

  Future<ResponseModel<Map<String, dynamic>>> getPlaceAutoComplete(String input,
          {String sessionId, String lat, String lng}) =>
      dioRequests.get<Map<String, dynamic>>(
        "$baseUrlGoogle/autocomplete/json?"
        "input=$input"
        "&types=tourist_attraction"
        "&location=$lat,$lng"
        "&key=$_apiKeyGoogle"
        "&sessiontoken=$sessionId",
      );

  Future<ResponseModel> getPhoto(String photoReference, {int maxWidth = 400}) =>
      dioRequests.get(
        "$baseUrlGoogle/photo?"
        "maxwidth=${maxWidth.toString()}"
        "&photoreference=$photoReference"
        "&key=$_apiKeyGoogle",
      );

  Future<ResponseModel<Map<String, dynamic>>> getPlaceDetails(String placeId,
          {String sessionId}) =>
      dioRequests.get<Map<String, dynamic>>(
        "$baseUrlGoogle/details/json?"
        "place_id=$placeId"
        "&sessiontoken=$sessionId"
        "&fields=name,rating,photo"
        "&key=$_apiKeyGoogle"
        "&language=pt-BR",
      );

  //dispose will be called automatically
  @override
  void dispose() {}
}
