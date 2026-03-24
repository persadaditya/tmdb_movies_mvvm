import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'video_viewmodel.dart';

class VideoViewTablet extends ViewModelWidget<VideoViewModel> {
  const VideoViewTablet({super.key});

  @override
  Widget build(BuildContext context, VideoViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI - VideoView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
