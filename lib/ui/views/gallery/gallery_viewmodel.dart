import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/model/movie_image.dart';

class GalleryViewModel extends BaseViewModel {
  final MovieImage movieImage;
  final _router = locator<RouterService>();

  GalleryViewModel(this.movieImage);

  void onImageTap(String url) {
    _router.navigateToImageView(url: url);
  }
}
