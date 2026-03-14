import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

class SignInViewModel extends BaseViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp() async {
    openUrl('https://www.themoviedb.org/signup');
  }
}
