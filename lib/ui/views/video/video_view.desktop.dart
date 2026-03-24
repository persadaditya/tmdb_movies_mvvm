import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'video_viewmodel.dart';

class VideoViewDesktop extends ViewModelWidget<VideoViewModel> {
  const VideoViewDesktop({super.key});

  @override
  Widget build(BuildContext context, VideoViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - VideoView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
