import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'video_view.desktop.dart';
import 'video_view.tablet.dart';
import 'video_view.mobile.dart';
import 'video_viewmodel.dart';

class VideoView extends StackedView<VideoViewModel> {
  const VideoView({super.key, this.youtubeKey});

  final String? youtubeKey;

  @override
  Widget builder(
    BuildContext context,
    VideoViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const VideoViewMobile(),
      tablet: (_) => const VideoViewTablet(),
      desktop: (_) => const VideoViewDesktop(),
    );
  }

  @override
  onViewModelReady(VideoViewModel viewModel) {
    viewModel.init();
  }

  @override
  VideoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VideoViewModel(youtubeId: youtubeKey ?? '');
}
