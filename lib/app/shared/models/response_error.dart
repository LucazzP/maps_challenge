class ResponseError implements Exception {
  final int statusCode;
  final String message;

  ResponseError({this.statusCode, this.message});
}