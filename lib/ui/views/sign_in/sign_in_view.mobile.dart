import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/constant/vectors.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/app_theme.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:tmdb_movies/ui/widgets/common/app_text_field/app_text_field.dart';

import 'sign_in_viewmodel.dart';

class SignInViewMobile extends ViewModelWidget<SignInViewModel> {
  const SignInViewMobile({super.key});

  @override
  Widget build(BuildContext context, SignInViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            verticalSpaceLarge,
            verticalSpaceMedium,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SvgPicture.asset(Vectors.logo),
                ),
                verticalSpaceMedium,
                Text(
                  'CINEMAX',
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                verticalSpaceMedium,
                Text(
                  'Login with your TMDB Account',
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpaceMedium,
                AppTextField(
                  controller: viewModel.usernameController,
                  labelText: 'Username',
                  hintText: 'your_username',
                ),
                verticalSpaceSmall,
                AppTextField(
                  controller: viewModel.passwordController,
                  labelText: 'Password',
                  hintText: 'password',
                  isPassword: true,
                ),
                verticalSpaceSmall,
                ElevatedButton(
                        onPressed: () {
                          viewModel.signIn();
                        },
                        child: const Text('Sign In'))
                    .withLoading(viewModel.busy('signIn')),
                verticalSpaceSmall,
                const Text('OR', textAlign: TextAlign.center),
                verticalSpaceSmall,
                ElevatedButton(
                        style: tertiaryButtonStyle,
                        onPressed: () {
                          viewModel.signInAsGuest();
                        },
                        child: const Text('Login as Guest'))
                    .withLoading(viewModel.busy('guestSignIn')),
                verticalSpaceMedium,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Don\'t have an account?',
                    style: textTheme.bodyMedium,
                  ),
                  horizontalSpaceSmall,
                  TextButton(
                    onPressed: () async {
                      viewModel.signUp();
                    },
                    child: Text(
                      'Sign Up',
                      style: textTheme.bodyMedium?.copyWith(
                        color: appColorPrimaryBlueAccent,
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
