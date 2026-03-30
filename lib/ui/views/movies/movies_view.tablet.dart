import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'movies_viewmodel.dart';

class MoviesViewTablet extends ViewModelWidget<MoviesViewModel> {
  const MoviesViewTablet({super.key});

  @override
  Widget build(BuildContext context, MoviesViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI - MoviesView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
