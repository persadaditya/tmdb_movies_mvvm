import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/model/genre.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/model/paginated.dart';
import 'package:tmdb_movies/network/api_client.dart';
import 'package:tmdb_movies/services/local_data_service.dart';

class MovieService {
  Dio get _client => ApiClient().dio;
  final _localDataService = locator<LocalDataService>();

  Future<Paginated<Movie>> loadUpcomingMovies({int page = 1}) async {
    final response = await _client.get(
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={${DateTime.now().add(const Duration(days: 1)).toIso8601String()}}&release_date.lte={${DateTime.now().add(const Duration(days: 14))}}',
        queryParameters: {
          'page': page,
        });
    return Paginated<Movie>.fromJson(
      response.data,
      (json) => Movie.fromJson(json),
    );
  }

  Future<Paginated<Movie>> loadPopularMovies({int page = 1}) async {
    final response = await _client.get('/movie/popular', queryParameters: {
      'page': page,
    });
    return Paginated<Movie>.fromJson(
      response.data,
      (json) => Movie.fromJson(json),
    );
  }

  Future<Paginated<Movie>> loadTopRatedMovies({int page = 1}) async {
    final response = await _client.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    return Paginated<Movie>.fromJson(
      response.data,
      (json) => Movie.fromJson(json),
    );
  }

  Future<Paginated<Movie>> loadNowPlayingMovies({int page = 1}) async {
    final response = await _client.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    return Paginated<Movie>.fromJson(
      response.data,
      (json) => Movie.fromJson(json),
    );
  }

  Future<Movie> loadMovie(int id) async {
    final response = await _client.get('/movie/$id');
    return Movie.fromJson(response.data);
  }

  Future<Paginated<Movie>> loadSimilarMovies(int id, {int page = 1}) async {
    final response = await _client.get('/movie/$id/similar', queryParameters: {
      'page': page,
    });
    return Paginated<Movie>.fromJson(
      response.data,
      (json) => Movie.fromJson(json),
    );
  }

  Future<List<Genre>> loadGenres() async {
    var localGenre = await _localDataService.getGenreMovies();
    if (localGenre != null) return localGenre;
    final response = await _client.get('/genre/movie/list');
    var genres = response.data['genres'] as List;
    await _localDataService
        .setGenreMovies(genres.map((json) => Genre.fromJson(json)).toList());
    return (response.data['genres'] as List)
        .map((json) => Genre.fromJson(json))
        .toList();
  }
}
