import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';

class ImageViewModel extends BaseViewModel {
  final String url;
  final _routerSercice = locator<RouterService>();

  ImageViewModel(this.url);

  void close() {
    _routerSercice.back();
  }
}
