import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'wishlist_view.desktop.dart';
import 'wishlist_view.tablet.dart';
import 'wishlist_view.mobile.dart';
import 'wishlist_viewmodel.dart';

class WishlistView extends StackedView<WishlistViewModel> {
  const WishlistView({super.key});

  @override
  Widget builder(
    BuildContext context,
    WishlistViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const WishlistViewMobile(),
      tablet: (_) => const WishlistViewTablet(),
      desktop: (_) => const WishlistViewDesktop(),
    );
  }

  @override
  WishlistViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WishlistViewModel();
}
