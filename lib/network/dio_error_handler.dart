import 'package:dio/dio.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';

class DioErrorHandler {
  static Future<AppException> handle(DioException error) async {
    // final navigationService = locator<RouterService>();

    ///check session
    // final localStorage = locator<LocalStorageService>();
    // var session = await localStorage.getSession();
    // if (session == null || session.isEmpty) {
    //   navigationService.replaceWithLoginView();
    //   return AppException('Session Expired');
    // }

    if (error.type == DioExceptionType.unknown) {
      return UnknownException();
    }
    if (error.type == DioExceptionType.cancel) {
      return AppException('request canceled');
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return TimeoutException();
    }

    if (error.type == DioExceptionType.connectionError) {
      return NetworkException();
    }

    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;
      if (statusCode != null) {
        if (statusCode == 400) {
          return AppException(data['status_message'], statusCode: statusCode);
        }
        // if (statusCode == 401) {
        //   ///navigate to login
        //   navigationService.replaceWithLoginView();
        //   return UnauthorizedException();
        // }

        if (statusCode >= 500) {
          return ServerException(statusCode);
        }
      }
      return AppException(
          error.response?.data.error.toString() ?? 'Request Failed',
          statusCode: statusCode);
    }

    return UnknownException();
  }
}
