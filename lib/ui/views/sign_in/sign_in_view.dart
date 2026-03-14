import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'sign_in_view.desktop.dart';
import 'sign_in_view.tablet.dart';
import 'sign_in_view.mobile.dart';
import 'sign_in_viewmodel.dart';

class SignInView extends StackedView<SignInViewModel> {
  const SignInView({super.key});

  @override
  Widget builder(
    BuildContext context,
    SignInViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const SignInViewMobile(),
      tablet: (_) => const SignInViewTablet(),
      desktop: (_) => const SignInViewDesktop(),
    );
  }

  @override
  void onViewModelReady(SignInViewModel viewModel) {
    // locator<SignInViewModel>();
    super.onViewModelReady(viewModel);
  }

  @override
  SignInViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignInViewModel();
}
