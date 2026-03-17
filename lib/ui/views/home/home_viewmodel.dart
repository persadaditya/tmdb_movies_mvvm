import 'package:flutter/material.dart';
import 'package:tmdb_movies/app/app.bottomsheets.dart';
import 'package:tmdb_movies/app/app.dialogs.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/model/user.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';
import 'package:tmdb_movies/services/auth_service.dart';
import 'package:tmdb_movies/services/user_service.dart';
import 'package:tmdb_movies/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _userApi = locator<UserService>();
  final _authService = locator<AuthService>();
  final _logger = getLogger('HomeViewModel');
  final _route = locator<RouterService>();

  User? user;

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  Future<void> init() async {
    user = await runBusyFuture(_userApi.me(), busyObject: 'user');
    notifyListeners();
  }

  void incrementCounter() async {
    _counter++;
    _userApi.clearUser();
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  void logout() async {
    await _authService.signOut();
    notifyListeners();
    _route.replaceWith(const SignInViewRoute());
  }

  @override
  void onFutureError(error, Object? key) {
    if (error.error is AppException) {
      _dialogService.showDialog(
        title: 'error',
        description: error.error.message,
      );
      return;
    }
    _dialogService.showDialog(
      title: 'error',
      description: error.message,
    );
    super.onFutureError(error, key);
  }
}
