import 'package:tmdb_movies/ui/common/app_constants.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: kdDesktopMaxContentWidth,
          height: kdDesktopMaxContentHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpaceLarge,
              Column(
                children: [
                  Text(
                    'Hello, DESKTOP UI!',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  verticalSpaceMedium,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
