import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'image_viewmodel.dart';

class ImageViewTablet extends ViewModelWidget<ImageViewModel> {
  const ImageViewTablet({super.key});

  @override
  Widget build(BuildContext context, ImageViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI - ImageView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
