import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewTablet extends ViewModelWidget<HomeViewModel> {
  const HomeViewTablet({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  verticalSpaceLarge,
                ]),
          ),
        ),
      ),
    );
  }
}
