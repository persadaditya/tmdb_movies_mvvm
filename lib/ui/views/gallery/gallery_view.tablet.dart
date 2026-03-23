import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'gallery_viewmodel.dart';

class GalleryViewTablet extends ViewModelWidget<GalleryViewModel> {
  const GalleryViewTablet({super.key});

  @override
  Widget build(BuildContext context, GalleryViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI - GalleryView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
