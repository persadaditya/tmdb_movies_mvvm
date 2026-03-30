import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'movies_viewmodel.dart';

class MoviesViewDesktop extends ViewModelWidget<MoviesViewModel> {
  const MoviesViewDesktop({super.key});

  @override
  Widget build(BuildContext context, MoviesViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - MoviesView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
