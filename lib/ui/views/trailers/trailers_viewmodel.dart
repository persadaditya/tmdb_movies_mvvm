import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/model/trailer.dart';
import 'package:tmdb_movies/services/trailer_service.dart';

class TrailersViewModel extends BaseViewModel {
  final int movieId;

  TrailersViewModel(this.movieId);

  final _trailerService = locator<TrailerService>();
  final _routerService = locator<RouterService>();

  List<Trailer> _trailers = [];
  List<Trailer> get trailers => _trailers;
  set trailers(List<Trailer> trailers) {
    _trailers = trailers;
    notifyListeners();
  }

  Future<void> loadTrailers() async {
    var response = await runBusyFuture(_trailerService.loadTrailers(movieId),
        busyObject: 'trailers');
    trailers = response.results ?? [];
  }

  void onTapTrailer(Trailer trailer) {
    _routerService.navigateToVideoView(youtubeKey: trailer.key ?? '');
  }
}
