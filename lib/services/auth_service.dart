import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/guest_session_response.dart';
import 'package:tmdb_movies/model/session_response.dart';
import 'package:tmdb_movies/model/token_response.dart';
import 'package:tmdb_movies/network/api_client.dart';
import 'package:tmdb_movies/services/local_data_service.dart';

class AuthService {
  Dio get client => ApiClient().dio;
  final _localData = locator<LocalDataService>();

  Future<TokenResponse?> createRequestToken() async {
    try {
      var response = await client.get('/authentication/token/new');
      var data = response.data;
      if (data == null) return null;
      return TokenResponse.fromJson(data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      getLogger('authService').e(e);
      rethrow;
    }
  }

  Future<SessionResponse?> createSession(String requestToken) async {
    try {
      var response = await client.post('/authentication/session/new',
          data: {'request_token': requestToken});
      var data = response.data;
      if (data == null) return null;
      return SessionResponse.fromJson(data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      getLogger('authService').e(e);
      rethrow;
    }
  }

  Future<TokenResponse?> createSessionWithLogin(
      String username, String password) async {
    try {
      var requestToken = await createRequestToken();
      var response =
          await client.post('/authentication/token/validate_with_login', data: {
        'username': username,
        'password': password,
        'request_token': requestToken?.requestToken
      });
      var data = response.data;
      if (data == null) return null;
      return TokenResponse.fromJson(data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      getLogger('authService').e(e);
      rethrow;
    }
  }

  Future<SessionResponse?> signIn(String username, String password) async {
    try {
      var requestToken = await createSessionWithLogin(username, password);
      if (requestToken == null) return null;
      var accessToken = requestToken.requestToken;
      var session = await createSession(accessToken);
      if (session == null) return null;
      await _localData.setSession(session.sessionId);
      return session;
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      getLogger('authService').e(e);
      rethrow;
    }
  }

  Future<GuestSessionResponse?> createGuestSession() async {
    try {
      var response = await client.get('/authentication/guest_session/new');
      var data = response.data;
      if (data == null) return null;
      var session = GuestSessionResponse.fromJson(data);
      await _localData.setSessionGuest(session.guestSessionId);
      return GuestSessionResponse.fromJson(data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      getLogger('authService').e(e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _localData.removeSession();
    await _localData.removeGuestSession();
  }

  Future<bool> isSignedIn() async {
    var session = await _localData.getSession();
    var guestSession = await _localData.getGuestSession();
    return session != null || guestSession != null;
  }
}
