class ResponseModel<T> {
  final int statusCode;
  final T data;

  ResponseModel({this.statusCode, this.data});
}