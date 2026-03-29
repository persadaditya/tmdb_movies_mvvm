import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.bottomsheets.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/model/country.dart';
import 'package:tmdb_movies/model/user.dart';
import 'package:tmdb_movies/network/exception/app_exception.dart';
import 'package:tmdb_movies/services/auth_service.dart';
import 'package:tmdb_movies/services/local_data_service.dart';
import 'package:tmdb_movies/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel {
  final _userApi = locator<UserService>();
  final _authApi = locator<AuthService>();
  final _dialog = locator<DialogService>();
  final _sheet = locator<BottomSheetService>();
  final _localDataService = locator<LocalDataService>();

  User user = User();
  Country? country;

  Future<void> loadUser() async {
    user = await runBusyFuture(_userApi.me()) ?? User();
  }

  Future<void> loadCountry() async {
    country = await runBusyFuture(_localDataService.getCountry());
    country ??= Country(
      iso31661: 'ID',
      englishName: 'Indonesia',
      nativeName: 'Default - Indonesia',
    );
  }

  Future<void> editProfile() async {
    var confirm = await _sheet.showBottomSheet(
      title: 'Edit Profile',
      description: 'Access this feature on the website',
      confirmButtonTitle: 'Go to Website',
    );
    if (confirm?.confirmed != true) return;
    await launchUrl(Uri.parse('https://www.themoviedb.org/settings/profile'));
  }

  Future<void> changePassword() async {
    var confirm = await _sheet.showBottomSheet(
      title: 'Change Password',
      description: 'Access this feature on the website',
      confirmButtonTitle: 'Go to Website',
    );
    if (confirm?.confirmed != true) return;
    await launchUrl(Uri.parse('https://www.themoviedb.org/settings/profile'));
  }

  Future<void> deleteAccount() async {
    var confirm = await _sheet.showCustomSheet(
      variant: BottomSheetType.confirmation,
      title: 'Delete Account',
      description: "Are you sure you want to delete your account? \n"
          "you will be redirected to the website to complete this action",
    );
    if (confirm?.confirmed != true) return;
    await launchUrl(
        Uri.parse('https://www.themoviedb.org/settings/delete-account'));
  }

  Future<void> toCountrySelection() async {
    var result = await _sheet.showCustomSheet(
      variant: BottomSheetType.countries,
      isScrollControlled: true,
      title: 'Select Country',
    );
    if (result?.confirmed != true) return;
    loadCountry();
  }

  Future<void> toPrivacyPolicyPage() async {
    await launchUrl(Uri.parse('https://www.themoviedb.org/privacy-policy'));
  }

  Future<void> toTermsOfUsePage() async {
    await launchUrl(Uri.parse('https://www.themoviedb.org/terms-of-use'));
  }

  Future<void> toDMCAPolicyPage() async {
    await launchUrl(Uri.parse('https://www.themoviedb.org/dmca-policy'));
  }

  Future<void> logout() async {
    var confirm = await _sheet.showCustomSheet(
      variant: BottomSheetType.confirmation,
      title: 'Logout',
      description: 'Are you sure you want to logout?',
    );
    if (confirm?.confirmed != true) return;
    await runBusyFuture(_authApi.signOut());
  }

  @override
  void onFutureError(error, Object? key) {
    if (error.error is AppException) {
      _dialog.showDialog(
        title: 'Error',
        description: error.error.message,
      );
      return;
    }
    _dialog.showDialog(
      title: 'Error',
      description: error.message,
    );
    super.onFutureError(error, key);
  }
}
