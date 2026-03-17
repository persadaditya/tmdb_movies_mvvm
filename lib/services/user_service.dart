import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/user.dart';
import 'package:tmdb_movies/network/api_client.dart';
import 'package:tmdb_movies/services/local_data_service.dart';

class UserService {
  final _localDataService = locator<LocalDataService>();
  final _apiClient = ApiClient().dio;
  final _logger = getLogger('userService');

  Future<User?> me() async {
    try {
      var userLocal = await _localDataService.getUser();
      _logger.d('userLocal:${userLocal?.toJson()}');
      if (userLocal != null) {
        return userLocal;
      }
      var session = await _localDataService.getSession();
      if (session == null) return null;
      final response = await _apiClient
          .get('/account', queryParameters: {"session_id": session});
      var user = User.fromJson(response.data);
      _localDataService.setUser(user);
      return User.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<void> clearUser() async {
    await _localDataService.removeUser();
  }
}
