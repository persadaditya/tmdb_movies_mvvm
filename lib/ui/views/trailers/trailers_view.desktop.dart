import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'trailers_viewmodel.dart';

class TrailersViewDesktop extends ViewModelWidget<TrailersViewModel> {
  const TrailersViewDesktop({super.key});

  @override
  Widget build(BuildContext context, TrailersViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - TrailersView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
