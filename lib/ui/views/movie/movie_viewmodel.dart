import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/cast_crew.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';
import 'package:tmdb_movies/services/cast_service.dart';
import 'package:tmdb_movies/services/movie_service.dart';

class MovieViewModel extends BaseViewModel {
  final int id;

  MovieViewModel({required this.id});

  final _movieApi = locator<MovieService>();
  final _castApi = locator<CastService>();
  final _dialogService = locator<DialogService>();
  Movie movie = Movie();

  bool seeMore = false;

  List<Cast> _casts = [];
  List<Cast> get casts => _casts;
  set casts(List<Cast> casts) {
    _casts = casts;
    notifyListeners();
  }

  Future<void> loadMovie() async {
    movie = await runBusyFuture(_movieApi.loadMovie(id), busyObject: 'movie');
    notifyListeners();
  }

  Future<void> loadCasts() async {
    var response =
        await runBusyFuture(_castApi.loadCast(id), busyObject: 'casts');
    casts = response?.cast ?? [];

    getLogger('MovieViewModel').d('cast: ${response?.cast} - ${response?.id}');
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
