import 'package:desafio_maps/app/shared/models/response_error.dart';
import 'package:desafio_maps/app/shared/models/response_model.dart';
import 'package:dio/dio.dart';

class DioRequests {
  final Dio dio;

  DioRequests(this.dio);

  Future<ResponseModel<T>> get<T>(String path) async{
    try {
      Response response = await dio.get(path);
      return ResponseModel<T>(
        statusCode: response.statusCode,
        data: response.data
      );
    } on DioError catch (e) {
      throw ResponseError(
          message: e.response.statusMessage,
          statusCode: e.response.statusCode
      );
    }
  }
}