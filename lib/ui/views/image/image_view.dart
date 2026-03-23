import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'image_view.desktop.dart';
import 'image_view.tablet.dart';
import 'image_view.mobile.dart';
import 'image_viewmodel.dart';

class ImageView extends StackedView<ImageViewModel> {
  const ImageView({super.key, required this.url});

  final String url;

  @override
  Widget builder(
    BuildContext context,
    ImageViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const ImageViewMobile(),
      tablet: (_) => const ImageViewTablet(),
      desktop: (_) => const ImageViewDesktop(),
    );
  }

  @override
  ImageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ImageViewModel(url);
}
