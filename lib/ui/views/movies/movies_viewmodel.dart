import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/model/genre.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';
import 'package:tmdb_movies/services/movie_service.dart';

class MoviesViewModel extends BaseViewModel {
  final _movieApi = locator<MovieService>();
  final _dialog = locator<DialogService>();

  final int? id;
  final MovieType type;
  MoviesViewModel(this.id, this.type);

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  Future<void> loadMovies(int? id, MovieType type) async {
    switch (type) {
      case MovieType.nowPlaying:
        var response = await runBusyFuture(_movieApi.loadNowPlayingMovies());
        _movies = response.results ?? [];
        page = response.page ?? 1;
        hasNextPage = page < (response.totalPages ?? 1);
        break;
      case MovieType.popular:
        var response = await runBusyFuture(_movieApi.loadPopularMovies());
        page = response.page ?? 1;
        hasNextPage = page < (response.totalPages ?? 1);
        _movies = response.results ?? [];
        break;
      case MovieType.similar:
        if (id != null) {
          var response = await runBusyFuture(_movieApi.loadSimilarMovies(id));
          page = response.page ?? 1;
          hasNextPage = page < (response.totalPages ?? 1);
          _movies = response.results ?? [];
        }
        break;
    }

    notifyListeners();
  }

  int page = 1;
  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;
  set hasNextPage(bool value) {
    _hasNextPage = value;
    notifyListeners();
  }

  Future<void> loadMore(int? id, MovieType type) async {
    switch (type) {
      case MovieType.nowPlaying:
        var response = await runBusyFuture(
            _movieApi.loadNowPlayingMovies(page: page + 1),
            busyObject: 'loadMore');
        _movies.addAll(response.results ?? []);
        page = response.page ?? 1;
        hasNextPage = page < (response.totalPages ?? 1);
        break;
      case MovieType.popular:
        var response = await runBusyFuture(
            _movieApi.loadPopularMovies(page: page + 1),
            busyObject: 'loadMore');
        _movies.addAll(response.results ?? []);
        page = response.page ?? 1;
        hasNextPage = page < (response.totalPages ?? 1);
        break;
      case MovieType.similar:
        if (id != null) {
          var response = await runBusyFuture(
              _movieApi.loadSimilarMovies(id, page: page + 1),
              busyObject: 'loadMore');
          _movies.addAll(response.results ?? []);
          page = response.page ?? 1;
          hasNextPage = page < (response.totalPages ?? 1);
        }
        break;
    }
    notifyListeners();
  }

  List<Genre> _genres = [];
  List<Genre> get genres => _genres;
  Future<void> loadGenres() async {
    _genres = await runBusyFuture(_movieApi.loadGenres());
    notifyListeners();
  }

  @override
  void onFutureError(error, Object? key) {
    if (error is AppException) {
      _dialog.showDialog(title: 'Error', description: error.message);
    }
    _dialog.showDialog(title: 'Error', description: error.message);
    super.onFutureError(error, key);
  }
}
