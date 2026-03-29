import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/model/country.dart';
import 'package:tmdb_movies/services/configuration_service.dart';
import 'package:tmdb_movies/services/local_data_service.dart';

class CountriesSheetModel extends BaseViewModel {
  final _configurationService = locator<ConfigurationService>();
  final _localDataService = locator<LocalDataService>();

  final controller = TextEditingController();

  bool _isSearch = false;
  bool get isSearch => _isSearch;
  void toggleSearch() {
    _isSearch = controller.text.isNotEmpty;
    rebuildUi();
  }

  List<Country> _countriesNetwork = [];
  List<Country> get countriesNetwork => _countriesNetwork;

  List<Country> _countries = [];
  List<Country> get countries => _countries;
  Future<void> loadCountries() async {
    _countries =
        await runBusyFuture(_configurationService.loadCountries()) ?? [];
    _countriesNetwork = _countries;
    rebuildUi();
  }

  Future<void> searchCountries(String query) async {
    if (query.isEmpty) {
      loadCountries();
      return;
    }
    _countries = _countries
        .where((country) =>
            country.englishName?.toLowerCase().contains(query.toLowerCase()) ==
                true ||
            country.nativeName?.toLowerCase().contains(query.toLowerCase()) ==
                true)
        .toList();
    rebuildUi();
  }

  Future<void> clearSearch() async {
    controller.clear();
    _countries = _countriesNetwork;
    toggleSearch();
  }

  Country? _selectedCountry;
  Country? get selectedCountry => _selectedCountry;
  void selectCountry(Country country) {
    _selectedCountry = country;
    rebuildUi();
  }

  Future<void> loadSelectedCountry() async {
    _selectedCountry = await runBusyFuture(_localDataService.getCountry());
    rebuildUi();
  }

  Future<void> saveCountry() async {
    if (_selectedCountry == null) return;
    await _localDataService.setCountry(_selectedCountry!);
  }
}
