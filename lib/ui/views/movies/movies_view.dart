import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/model/movie.dart';

import 'movies_view.desktop.dart';
import 'movies_view.tablet.dart';
import 'movies_view.mobile.dart';
import 'movies_viewmodel.dart';

class MoviesView extends StackedView<MoviesViewModel> {
  const MoviesView({super.key, this.id, required this.type});

  final int? id;
  final MovieType type;

  @override
  Widget builder(
    BuildContext context,
    MoviesViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MoviesViewMobile(),
      tablet: (_) => const MoviesViewTablet(),
      desktop: (_) => const MoviesViewDesktop(),
    );
  }

  @override
  void onViewModelReady(MoviesViewModel viewModel) {
    viewModel.loadGenres();
    viewModel.loadMovies(id, type);
    super.onViewModelReady(viewModel);
  }

  @override
  MoviesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MoviesViewModel(id, type);
}
