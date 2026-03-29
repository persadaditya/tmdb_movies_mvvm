# TMDB Movies - Feature Implementation Guide

## Project Overview

This is a Flutter movie application built using the **Stacked architecture** that integrates with The Movie Database (TMDB) API. The app follows a clean architecture pattern with clear separation of concerns.

### Key Technologies

- **Flutter** with Dart
- **Stacked Architecture** (MVVM with dependency injection)
- **Dio** for HTTP requests
- **Responsive Builder** for multi-platform support
- **Golden Tests** for UI testing

## Architecture Pattern: Stacked MVVM

The project uses the Stacked architecture which consists of:

```
View (UI) → ViewModel (Business Logic) → Service (Data Layer) → API/Repository
```

### Key Components

1. **Views**: UI components (`.dart` files in `lib/ui/views/`)
2. **ViewModels**: Business logic and state management
3. **Services**: Data access and API integration
4. **Models**: Data transfer objects
5. **Locator**: Dependency injection container

## Step-by-Step Guide: Adding a New Feature

### Example 1: Adding "Now Playing" Movies Feature

#### Step 1: Analyze TMDB API Endpoint

First, check the TMDB API documentation for the "Now Playing" endpoint:

- Endpoint: `/movie/now_playing`
- Returns: Paginated list of movies currently in theaters

#### Step 2: Add Method to MovieService

Add the API call to `lib/services/movie_service.dart`:

```dart
Future<Paginated<Movie>> loadNowPlayingMovies({int page = 1}) async {
  final response = await _client.get('/movie/now_playing', queryParameters: {
    'page': page,
    'region': 'ID', // Optional: filter by region
  });
  return Paginated<Movie>.fromJson(
    response.data,
    (json) => Movie.fromJson(json),
  );
}
```

#### Step 3: Update ViewModel

Add the method to your ViewModel (e.g., `home_viewmodel.dart`):

```dart
List<Movie> nowPlayingMovies = [];

Future<void> loadNowPlayingMovies() async {
  var paginatedMovies = await runBusyFuture(
    _movieApi.loadNowPlayingMovies(page: 1),
    busyObject: 'nowPlaying',
  );
  nowPlayingMovies = paginatedMovies.results ?? [];
  notifyListeners();
}
```

#### Step 4: Create UI Component

Create a widget to display now playing movies in `lib/ui/widgets/common/item/` or add to existing view:

```dart
class NowPlayingSection extends StatelessWidget {
  final List<Movie> movies;
  
  const NowPlayingSection({super.key, required this.movies});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Now Playing', style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ItemMovie(movie: movie);
            },
          ),
        ),
      ],
    );
  }
}
```

#### Step 5: Integrate into View

Add the section to your view file:

```dart
@override
Widget build(BuildContext context) {
  return ViewModelBuilder<HomeViewModel>.reactive(
    viewModelBuilder: () => HomeViewModel(),
    onViewModelReady: (model) => model.init(),
    builder: (context, model, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Existing content...
              NowPlayingSection(movies: model.nowPlayingMovies),
              // More content...
            ],
          ),
        ),
      );
    },
  );
}
```

#### Step 6: Update ViewModel Initialization

Call the new method in your ViewModel's `init()` method:

```dart
Future<void> init() async {
  user = await runBusyFuture(_userApi.me(), busyObject: 'user');
  loadMovies();
  loadGenres();
  loadPopularMovies();
  loadTopRatedMovies();
  loadNowPlayingMovies(); // Add this line
  notifyListeners();
}
```

### Example 2: Adding User Ratings Functionality

#### Step 1: Create Rating Model

Add a new model in `lib/model/`:

```dart
// lib/model/rating.dart
class Rating {
  final int movieId;
  final double value;
  final DateTime createdAt;
  
  Rating({
    required this.movieId,
    required this.value,
    required this.createdAt,
  });
  
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      movieId: json['movie_id'],
      value: json['value'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieId,
      'value': value,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
```

#### Step 2: Create Rating Service

Create `lib/services/rating_service.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/model/rating.dart';
import 'package:tmdb_movies/network/api_client.dart';
import 'package:tmdb_movies/services/local_data_service.dart';

class RatingService {
  Dio get _client => ApiClient().dio;
  final _localDataService = locator<LocalDataService>();
  
  Future<void> rateMovie(int movieId, double rating) async {
    final sessionId = await _localDataService.getSessionId();
    
    await _client.post(
      '/movie/$movieId/rating',
      data: {'value': rating},
      queryParameters: {'session_id': sessionId},
    );
  }
  
  Future<List<Rating>> getUserRatings() async {
    final sessionId = await _localDataService.getSessionId();
    final accountId = await _localDataService.getAccountId();
    
    final response = await _client.get(
      '/account/$accountId/rated/movies',
      queryParameters: {'session_id': sessionId},
    );
    
    final results = response.data['results'] as List;
    return results.map((json) => Rating.fromJson(json)).toList();
  }
}
```

#### Step 3: Register Service in App

Update `lib/app/app.dart` to include the RatingService:

```dart
// Add import
import 'package:tmdb_movies/services/rating_service.dart';

@StackedApp(
  // ... existing code
  dependencies: [
    // ... existing dependencies
    LazySingleton(classType: RatingService),
  ],
  // ... rest of code
)
```

#### Step 4: Create Rating Widget

Create `lib/ui/widgets/common/rating_widget.dart`:

```dart
class RatingWidget extends StatelessWidget {
  final double initialRating;
  final Function(double) onRatingChanged;
  
  const RatingWidget({
    super.key,
    required this.initialRating,
    required this.onRatingChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingChanged,
    );
  }
}
```

#### Step 5: Integrate into Movie View

Add rating functionality to the movie view:

```dart
// In movie_viewmodel.dart
final _ratingService = locator<RatingService>();
double userRating = 0;

Future<void> rateMovie(double rating) async {
  await runBusyFuture(
    _ratingService.rateMovie(movie.id, rating),
    busyObject: 'rating',
  );
  userRating = rating;
  notifyListeners();
}
```

## Testing Patterns

### Golden Tests

The project uses golden tests for UI regression testing:

```bash
# Run golden tests
flutter test --update-goldens

# Test files are stored in:
test/golden/
```

### Service Tests

Service tests use Mockito for mocking dependencies:

```dart
// Example test structure
group('MovieServiceTest -', () {
  setUp(() => registerServices());
  tearDown(() => locator.reset());
  
  test('loadNowPlayingMovies should return paginated movies', () async {
    // Test implementation
  });
});
```

### ViewModel Tests

ViewModel tests focus on business logic:

```dart
group('HomeViewModelTest -', () {
  late HomeViewModel model;
  
  setUp(() {
    registerServices();
    model = HomeViewModel();
  });
  
  test('init should load all movie categories', () async {
    await model.init();
    expect(model.movies, isNotEmpty);
    expect(model.nowPlayingMovies, isNotEmpty);
  });
});
```

## Best Practices

### 1. State Management

- Use `runBusyFuture` for async operations with loading states
- Call `notifyListeners()` after state changes
- Use `busyObject` for granular loading states

### 2. Error Handling

- Wrap API calls in try-catch blocks
- Use the built-in exception classes in `lib/network/exception/`
- Show user-friendly error messages

### 3. Responsive Design

- Create separate files for `.mobile.dart`, `.tablet.dart`, `.desktop.dart`
- Use `ResponsiveBuilder` widget
- Test on different screen sizes

### 4. Code Organization

- Keep views dumb (minimal logic)
- Put business logic in ViewModels
- Separate data access to Services
- Use consistent naming conventions

## Common Pitfalls & Solutions

### 1. API Key Management

**Problem**: TMDB API requires authentication
**Solution**: Store API key in `.env` file and load with `flutter_dotenv`

### 2. Pagination

**Problem**: Loading large datasets
**Solution**: Use `Paginated<T>` model and implement lazy loading

### 3. Image Loading

**Problem**: Network images may fail to load
**Solution**: Use `cached_network_image` with error widgets

### 4. State Persistence

**Problem**: Losing state on app restart
**Solution**: Use `shared_preferences` via `LocalDataService`

## Development Workflow

1. **Plan**: Define feature requirements and API endpoints
2. **Model**: Create or update data models
3. **Service**: Implement API calls in service layer
4. **ViewModel**: Add business logic and state management
5. **View**: Create UI components
6. **Test**: Write unit and widget tests
7. **Refine**: Optimize performance and UX

## Useful Commands

```bash
# Generate stacked files (routes, locator)
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Run golden tests
flutter test --update-goldens

# Generate app icons
dart run flutter_launcher_icons:generate

# Change package name
dart run change_app_package_name:main com.new.package.name
```

## Conclusion

This Flutter TMDB Movies project demonstrates a well-structured implementation using the Stacked architecture. By following the patterns established in the codebase, you can efficiently add new features while maintaining code quality and testability.

Remember to:

1. Follow the existing patterns and conventions
2. Write tests for new functionality
3. Consider responsive design for all platforms
4. Handle errors gracefully
5. Document complex logic

For more information, refer to:

- [Stacked Documentation](https://stacked.filledstacks.com/)
- [TMDB API Documentation](https://developers.themoviedb.org/3)
- [Flutter Documentation](https://flutter.dev/docs)
