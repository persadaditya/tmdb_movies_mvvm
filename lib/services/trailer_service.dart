import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/paginated.dart';
import 'package:tmdb_movies/model/trailer.dart';
import 'package:tmdb_movies/network/api_client.dart';

class TrailerService {
  Dio get _client => ApiClient().dio;

  Future<Paginated<Trailer>> loadTrailers(int movieId) async {
    try {
      final response = await _client.get('/movie/$movieId/videos');
      return Paginated<Trailer>.fromJson(
        response.data,
        (json) => Trailer.fromJson(json),
      );
    } catch (e) {
      getLogger('trailer').e(e);
      rethrow;
    }
  }
}
