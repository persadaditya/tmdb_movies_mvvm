import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'wishlist_viewmodel.dart';

class WishlistViewDesktop extends ViewModelWidget<WishlistViewModel> {
  const WishlistViewDesktop({super.key});

  @override
  Widget build(BuildContext context, WishlistViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - WishlistView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
