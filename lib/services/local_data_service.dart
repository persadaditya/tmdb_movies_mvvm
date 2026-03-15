import 'package:shared_preferences/shared_preferences.dart';

class LocalDataService {
  Future<String?> getSession() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('session'));
  }

  Future<void> setSession(String session) async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('session', session));
  }

  Future<String?> getGuestSession() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('guest_session'));
  }

  Future<void> setSessionGuest(String guestSession) async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('guest_session', guestSession));
  }

  Future<void> removeSession() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.remove('session'));
  }

  Future<void> removeGuestSession() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.remove('guest_session'));
  }
}
