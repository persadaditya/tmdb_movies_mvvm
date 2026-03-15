import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'wishlist_viewmodel.dart';

class WishlistViewTablet extends ViewModelWidget<WishlistViewModel> {
  const WishlistViewTablet({super.key});

  @override
  Widget build(BuildContext context, WishlistViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI - WishlistView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
