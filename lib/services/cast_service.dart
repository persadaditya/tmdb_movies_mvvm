import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/cast_crew.dart';
import 'package:tmdb_movies/network/api_client.dart';

class CastService {
  Dio get _client => ApiClient().dio;

  Future<CastResponse?> loadCast(int id) async {
    try {
      final response = await _client.get('/movie/$id/credits');
      final data =
          response.data is String ? jsonDecode(response.data) : response.data;

      final castResponse = CastResponse.fromJson(data);
      return castResponse;
    } catch (e, s) {
      getLogger('cast').e('error', e, s);
      return null;
    }
  }
}
