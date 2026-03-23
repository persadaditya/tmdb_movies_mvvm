import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'movie_view.desktop.dart';
import 'movie_view.tablet.dart';
import 'movie_view.mobile.dart';
import 'movie_viewmodel.dart';

class MovieView extends StackedView<MovieViewModel> {
  const MovieView({super.key, required this.id});

  final int id;

  @override
  Widget builder(
    BuildContext context,
    MovieViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.busy('movie') || viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ScreenTypeLayout.builder(
              mobile: (_) => const MovieViewMobile(),
              tablet: (_) => const MovieViewTablet(),
              desktop: (_) => const MovieViewDesktop(),
            ),
    );
  }

  @override
  void onViewModelReady(MovieViewModel viewModel) async {
    await viewModel.loadMovie();
    await viewModel.loadCasts();
    await viewModel.loadImages();
    await viewModel.loadReviews();
    await viewModel.loadSimilarMovies();
    super.onViewModelReady(viewModel);
  }

  @override
  MovieViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MovieViewModel(id: id);
}
