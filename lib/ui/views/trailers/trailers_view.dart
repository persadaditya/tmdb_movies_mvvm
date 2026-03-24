import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'trailers_view.desktop.dart';
import 'trailers_view.tablet.dart';
import 'trailers_view.mobile.dart';
import 'trailers_viewmodel.dart';

class TrailersView extends StackedView<TrailersViewModel> {
  const TrailersView({super.key, required this.movieId});

  final int movieId;

  @override
  Widget builder(
    BuildContext context,
    TrailersViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.busy('trailers')
          ? const Center(child: CircularProgressIndicator())
          : ScreenTypeLayout.builder(
              mobile: (_) => const TrailersViewMobile(),
              tablet: (_) => const TrailersViewTablet(),
              desktop: (_) => const TrailersViewDesktop(),
            ),
    );
  }

  @override
  void onViewModelReady(TrailersViewModel viewModel) {
    viewModel.loadTrailers();
    super.onViewModelReady(viewModel);
  }

  @override
  TrailersViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TrailersViewModel(movieId);
}
