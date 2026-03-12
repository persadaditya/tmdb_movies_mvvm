class AppException implements Exception {
  final String message;
  final int? statusCode;
  AppException(this.message, {this.statusCode});
}

class NetworkException extends AppException {
  NetworkException() : super("No Internet Connection");
}

class TimeoutException extends AppException {
  TimeoutException() : super("Connection Timeout");
}

class UnauthorizedException extends AppException {
  UnauthorizedException() : super("Session Expired", statusCode: 401);
}

class ServerException extends AppException {
  ServerException(int code) : super("Server error", statusCode: code);
}

class UnknownException extends AppException {
  UnknownException() : super("Unexpected error occurred");
}
