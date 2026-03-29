import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.logger.dart';
import 'package:tmdb_movies/model/country.dart';
import 'package:tmdb_movies/network/api_client.dart';

class ConfigurationService {
  Dio get client => ApiClient().dio;

  Future<List<Country>> loadCountries() async {
    try {
      final response = await client.get('/configuration/countries');
      final data = response.data as List;
      return data.map((e) => Country.fromJson(e)).toList();
    } on DioException catch (e) {
      getLogger('ConfigurationService').e('Failed to load countries', e);
      rethrow;
    } catch (e) {
      getLogger('ConfigurationService')
          .e('Unexpected error loading countries', e);
      rethrow;
    }
  }
}
