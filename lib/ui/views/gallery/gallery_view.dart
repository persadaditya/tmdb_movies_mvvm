import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/model/movie_image.dart';

import 'gallery_view.desktop.dart';
import 'gallery_view.tablet.dart';
import 'gallery_view.mobile.dart';
import 'gallery_viewmodel.dart';

class GalleryView extends StackedView<GalleryViewModel> {
  const GalleryView({super.key, required this.movieImage});
  final MovieImage movieImage;

  @override
  Widget builder(
    BuildContext context,
    GalleryViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const GalleryViewMobile(),
      tablet: (_) => const GalleryViewTablet(),
      desktop: (_) => const GalleryViewDesktop(),
    );
  }

  @override
  GalleryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      GalleryViewModel(movieImage);
}
