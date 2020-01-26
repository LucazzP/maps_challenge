import 'package:desafio_maps/app/shared/models/response_model.dart';
import 'package:desafio_maps/app/shared/repositories/dio_requests.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class HomeRepository extends Disposable {
  final DioRequests dioRequests;
  String apiKeyGoogle;

  HomeRepository(
    Dio dio, {
    this.apiKeyGoogle,
  }) : dioRequests = DioRequests(dio);

  final String baseUrlGoogle = "https://maps.googleapis.com/maps/api/place";

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
        "&fields=name,rating,photo"
        "&key=$apiKeyGoogle"
        "&language=pt-BR",
      );

  //dispose will be called automatically
  @override
  void dispose() {}
}
