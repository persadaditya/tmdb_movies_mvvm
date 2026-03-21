import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/model/genre.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/model/user.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';
import 'package:tmdb_movies/services/auth_service.dart';
import 'package:tmdb_movies/services/movie_service.dart';
import 'package:tmdb_movies/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _dialogService = locator<DialogService>();
  final _userApi = locator<UserService>();
  final _authService = locator<AuthService>();
  final _route = locator<RouterService>();
  final _movieApi = locator<MovieService>();
  final _routerService = locator<RouterService>();

  final CarouselSliderController sliderController = CarouselSliderController();

  User? user;

  List<Movie> movies = [];
  List<Movie> moviesByPopular = [];
  List<Movie> moviesByTopRated = [];

  List<Genre> genres = [];

  Future<void> init() async {
    user = await runBusyFuture(_userApi.me(), busyObject: 'user');
    loadMovies();
    loadGenres();
    loadPopularMovies();
    loadTopRatedMovies();
    notifyListeners();
  }

  Future<void> loadMovies() async {
    var paginatedMovies = await runBusyFuture(
        _movieApi.loadUpcomingMovies(page: 1),
        busyObject: 'movies');
    var result = paginatedMovies.results?.reversed.toList() ?? [];
    var filtered = <Movie>[];
    for (int i = 0; i < result.length; i++) {
      if (i < 7) {
        filtered.add(result[i]);
      }
    }
    movies = filtered;
    notifyListeners();
  }

  Future<void> loadPopularMovies() async {
    var paginatedMovies = await runBusyFuture(
        _movieApi.loadPopularMovies(page: 1),
        busyObject: 'movies');
    var result = paginatedMovies.results ?? [];
    moviesByPopular = result;
    notifyListeners();
  }

  Future<void> loadTopRatedMovies() async {
    var paginatedMovies = await runBusyFuture(
        _movieApi.loadTopRatedMovies(page: 1),
        busyObject: 'movies');
    var result = paginatedMovies.results ?? [];
    moviesByTopRated = result;
    notifyListeners();
  }

  Future<void> loadGenres() async {
    genres = await runBusyFuture(_movieApi.loadGenres(), busyObject: 'genres');
    notifyListeners();
  }

  String getGenresName(List<int> ids) {
    return genres
        .where((genre) => ids.contains(genre.id))
        .map((genre) => genre.name)
        .join(', ');
  }

  void logout() async {
    await _authService.signOut();
    notifyListeners();
    _route.replaceWith(const SignInViewRoute());
  }

  void navigateToMovie(int id) {
    _routerService.navigateTo(MovieViewRoute(id: id));
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
