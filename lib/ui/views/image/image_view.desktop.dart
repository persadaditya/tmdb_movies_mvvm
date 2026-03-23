import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'image_viewmodel.dart';

class ImageViewDesktop extends ViewModelWidget<ImageViewModel> {
  const ImageViewDesktop({super.key});

  @override
  Widget build(BuildContext context, ImageViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - ImageView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
