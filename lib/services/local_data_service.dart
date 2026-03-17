import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_movies/model/user.dart';

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

  Future<User?> getUser() async {
    var userData = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('user'));
    if (userData == null) return null;
    return SharedPreferences.getInstance()
        .then((prefs) => User.fromJson(jsonDecode(userData)));
  }

  Future<void> setUser(User user) async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('user', jsonEncode(user.toJson())));
  }

  Future<void> removeUser() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.remove('user'));
  }
}
