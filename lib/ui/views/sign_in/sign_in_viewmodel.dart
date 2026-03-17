import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';
import 'package:tmdb_movies/services/auth_service.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

class SignInViewModel extends BaseViewModel {
  final authApi = locator<AuthService>();
  final _dialog = locator<DialogService>();
  final _router = locator<RouterService>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp() async {
    openUrl('https://www.themoviedb.org/signup');
  }

  Future<void> signIn() async {
    await runBusyFuture(
        authApi.signIn(
          usernameController.text,
          passwordController.text,
        ),
        busyObject: 'signIn');

    _router.replaceWith(const DashboardViewRoute());
  }

  Future<void> signInAsGuest() async {
    await runBusyFuture(authApi.createGuestSession(),
        busyObject: 'guestSignIn');

    _router.replaceWith(const DashboardViewRoute());
  }

  @override
  void onFutureError(error, Object? key) {
    if (error.error is UnauthorizedException) {
      _dialog.showDialog(
        title: 'Error',
        description: 'username or password is incorrect',
      );
      return;
    }
    if (error.error is AppException) {
      _dialog.showDialog(
        title: 'Error',
        description: error.message,
      );
      return;
    }
    if (error is UnauthorizedException) {
      _dialog.showDialog(
        title: 'Error',
        description: error.message,
      );
      return;
    }
    _dialog.showDialog(
      title: 'Error',
      description: error.toString(),
    );
    getLogger('signINVM').e(error);
    super.onFutureError(error, key);
  }
}
