import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';

import 'image_viewmodel.dart';

class ImageViewMobile extends ViewModelWidget<ImageViewModel> {
  const ImageViewMobile({super.key});

  @override
  Widget build(BuildContext context, ImageViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: viewModel.close, icon: const Icon(Icons.close))
        ],
      ),
      body: PhotoView(imageProvider: CachedNetworkImageProvider(viewModel.url)),
    );
  }
}
