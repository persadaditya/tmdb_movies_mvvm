import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/services/movie_service.dart';

class MovieViewModel extends BaseViewModel {
  final int id;

  MovieViewModel({required this.id}) {
    loadMovie();
  }

  final _movieApi = locator<MovieService>();
  Movie movie = Movie();

  bool seeMore = false;

  Future<void> loadMovie() async {
    movie = await runBusyFuture(_movieApi.loadMovie(id), busyObject: 'movie');
    notifyListeners();
  }
}
