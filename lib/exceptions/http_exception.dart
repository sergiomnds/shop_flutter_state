class HttpExceptionExample implements Exception {
  final String msg;
  final int statusCode;

  HttpExceptionExample({required this.msg, required this.statusCode});

  @override
  String toString() {
    return msg;
  }
}
