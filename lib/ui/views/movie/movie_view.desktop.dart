import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'movie_viewmodel.dart';

class MovieViewDesktop extends ViewModelWidget<MovieViewModel> {
  const MovieViewDesktop({super.key});

  @override
  Widget build(BuildContext context, MovieViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - MovieView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
