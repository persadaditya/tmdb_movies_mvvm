import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_movies/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ImageViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
