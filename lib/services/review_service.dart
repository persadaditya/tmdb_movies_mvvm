import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/paginated.dart';
import 'package:tmdb_movies/model/review.dart';
import 'package:tmdb_movies/network/api_client.dart';

class ReviewService {
  Dio get _client => ApiClient().dio;

  Future<Paginated<Review>> loadMovieReviews(int id, {int page = 1}) async {
    try {
      final response =
          await _client.get('/movie/$id/reviews', queryParameters: {
        'page': page,
      });
      return Paginated<Review>.fromJson(
        response.data,
        (json) => Review.fromJson(json),
      );
    } catch (e) {
      getLogger('review').e(e);
      rethrow;
    }
  }
}
