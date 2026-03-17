import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/guest_session_response.dart';
import 'package:tmdb_movies/model/session_response.dart';
import 'package:tmdb_movies/model/token_response.dart';
import 'package:tmdb_movies/network/api_client.dart';
import 'package:tmdb_movies/services/local_data_service.dart';
import 'package:tmdb_movies/services/user_service.dart';

class AuthService {
  Dio get client => ApiClient().dio;

  final _localData = locator<LocalDataService>();
  final _userApi = locator<UserService>();
  final _logger = getLogger('AuthService');

  Future<String?> createRequestToken() async {
    try {
      _logger.i('Creating request token...');

      final response = await client.get('/authentication/token/new');
      final data = response.data;

      if (data == null) {
        _logger.w('Request token response is null');
        return null;
      }

      final token = TokenResponse.fromJson(data);

      _logger.i('Request token created: ${token.requestToken}');

      return token.requestToken;
    } on DioException catch (e) {
      _logger.e('Failed to create request token', e);
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error creating request token', e);
      rethrow;
    }
  }

  Future<String> validateLogin(
    String username,
    String password,
    String requestToken,
  ) async {
    try {
      _logger.i('Validating login for user: $username');
      _logger.d('Using request token: $requestToken');

      final response = await client.post(
        '/authentication/token/validate_with_login',
        data: {
          "username": username,
          "password": password,
          "request_token": requestToken,
        },
      );

      final token = TokenResponse.fromJson(response.data);

      if (token.success != true) {
        _logger.e('Login validation failed for user: $username');
        throw Exception("Login validation failed");
      }

      _logger.i('Login validated successfully for user: $username');

      return token.requestToken;
    } on DioException catch (e) {
      _logger.e('Login validation request failed', e);
      rethrow;
    }
  }

  Future<String> createSession(String requestToken) async {
    try {
      _logger.i('Creating session...');
      _logger.d('Using request token: $requestToken');

      final response = await client.post(
        '/authentication/session/new',
        data: {
          "request_token": requestToken,
        },
      );

      final data = response.data;

      if (data == null) {
        _logger.e('Session creation response is null');
        throw Exception("Session creation failed");
      }

      final session = SessionResponse.fromJson(data);

      _logger.i('Session created: ${session.sessionId}');

      return session.sessionId;
    } on DioException catch (e) {
      _logger.e('Failed to create session', e);
      rethrow;
    }
  }

  Future<void> signIn(String username, String password) async {
    try {
      _logger.i('Starting sign in process for user: $username');

      final requestToken = await createRequestToken();

      if (requestToken == null) {
        _logger.e('Request token is null');
        throw Exception('Failed to create request token');
      }

      final validatedToken = await validateLogin(
        username,
        password,
        requestToken,
      );

      final sessionId = await createSession(validatedToken);

      await _localData.setSession(sessionId);

      _logger.i('Fetching account details...');

      final account = await _userApi.me();

      if (account == null) {
        _logger.e('Account API returned null');
        throw Exception('Failed to get user');
      }

      _logger.i('Account fetched: ${account.username} (id: ${account.id})');

      await _localData.setUser(account);

      _logger.i('Session and user stored locally');
      _logger.i('Sign in successful for user: ${account.username}');
    } catch (e, stack) {
      _logger.e('Sign in failed', e, stack);
      rethrow;
    }
  }

  Future<GuestSessionResponse?> createGuestSession() async {
    try {
      _logger.i('Creating guest session...');

      final response = await client.get('/authentication/guest_session/new');
      final data = response.data;

      if (data == null) {
        _logger.w('Guest session response is null');
        return null;
      }

      final session = GuestSessionResponse.fromJson(data);

      await _localData.setSessionGuest(session.guestSessionId);

      _logger.i('Guest session created: ${session.guestSessionId}');

      return session;
    } on DioException catch (e) {
      _logger.e('Failed to create guest session', e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      _logger.i('Signing out user...');

      final sessionId = await _localData.getSession();

      if (sessionId != null) {
        _logger.d('Deleting session: $sessionId');

        await client.delete(
          '/authentication/session',
          data: {'session_id': sessionId},
        );

        _logger.i('Session deleted from TMDB');
      }

      await _localData.removeSession();
      await _localData.removeGuestSession();
      await _localData.removeUser();

      _logger.i('Local session cleared');
    } on DioException catch (e) {
      _logger.e('Sign out failed', e);
      rethrow;
    }
  }

  Future<bool> isSignedIn() async {
    final session = await _localData.getSession();
    final guestSession = await _localData.getGuestSession();

    final signedIn = session != null || guestSession != null;

    _logger.d('isSignedIn check -> $signedIn');

    return signedIn;
  }
}
