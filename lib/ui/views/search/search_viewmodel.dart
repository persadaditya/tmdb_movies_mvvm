import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/model/genre.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';
import 'package:tmdb_movies/services/movie_service.dart';

class SearchViewModel extends BaseViewModel {
  final _movieApi = locator<MovieService>();
  final _dialogService = locator<DialogService>();
  final _router = locator<RouterService>();
  final controller = TextEditingController();

  Movie _latestMovie = Movie();
  Movie get latestMovie => _latestMovie;

  List<Movie> _searchResults = [];
  List<Movie> get searchResults => _searchResults;

  List<Genre> _genres = [];
  List<Genre> get genres => _genres;

  Future<void> loadGenres() async {
    _genres = await runBusyFuture(_movieApi.loadGenres());
    notifyListeners();
  }

  bool _isSearch = false;
  bool get isSearch => _isSearch;
  void toggleSearch() {
    _isSearch = controller.text.isEmpty ? false : true;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    var response = await runBusyFuture(_movieApi.loadSearchMovies(query));
    _searchResults = response.results ?? [];
    notifyListeners();
  }

  Future<void> loadLatestMovie() async {
    var upcoming = await runBusyFuture(_movieApi.loadUpcomingMovies(page: 1));
    setBusy(true);
    var result = upcoming.results ?? [];
    _latestMovie = result[Random().nextInt(result.length)];
    setBusy(false);
    notifyListeners();
  }

  void onTapMovie(int id) {
    _router.navigateToMovieView(id: id);
  }

  @override
  void onFutureError(error, Object? key) {
    if (error.error is AppException) {
      _dialogService.showDialog(
        title: 'error',
        description: error.error.message,
      );
      return;
    }
    _dialogService.showDialog(
      title: 'error',
      description: error.message,
    );
    super.onFutureError(error, key);
  }
}
