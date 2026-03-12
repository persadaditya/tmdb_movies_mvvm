import 'package:dio/dio.dart';
import 'package:tmdb_movies/network/header_interceptor.dart';
import 'package:tmdb_movies/network/pretty_dio_logger.dart';

class ApiClient {
  final String baseUrl = "https://api.themoviedb.org/3";

  late Dio dio;
  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }
}
