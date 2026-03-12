import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/network/dio_error_handler.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  final String _apiKey = dotenv.env['API_KEY'] ?? '';
  final logger = getLogger('interceptor');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeader) {
      options.headers.addAll(customHeader);
    });
    super.onRequest(options, handler);
  }

  Future<Map<String, dynamic>> getCustomHeaders() async {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $_apiKey',
    };
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = DioErrorHandler.handle(err);
    logger.e(err.toString, [err]);
    return handler.reject(
        DioException(requestOptions: err.requestOptions, error: appException));
  }
}
