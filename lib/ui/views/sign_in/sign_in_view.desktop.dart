import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'sign_in_viewmodel.dart';

class SignInViewDesktop extends ViewModelWidget<SignInViewModel> {
  const SignInViewDesktop({super.key});

  @override
  Widget build(BuildContext context, SignInViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - SignInView!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
