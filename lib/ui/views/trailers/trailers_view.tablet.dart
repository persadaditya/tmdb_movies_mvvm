import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'trailers_viewmodel.dart';

class TrailersViewTablet extends ViewModelWidget<TrailersViewModel> {
  const TrailersViewTablet({super.key});

  @override
  Widget build(BuildContext context, TrailersViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI - TrailersView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
