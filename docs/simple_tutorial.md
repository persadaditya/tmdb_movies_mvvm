
# Building a TMDB Movie App with Flutter & Stacked MVVM

## A Step-by-Step Tutorial Based on Real Development Commits

### What You'll Build

A fully-featured movie browsing app with:

- Authentication (guest & user sessions)
- Movie browsing (now playing, popular, top rated, upcoming)
- Movie details with credits, images, reviews, and trailers
- Search functionality
- Wishlist (favorites)
- Responsive design (mobile, tablet, desktop)

---

## Phase 1: Project Setup & Initial Structure (Commit 1)

**Commit:** `c7a0d3a - initial commit`

This is the base Flutter project created with Stacked CLI:

```bash
stacked create app tmdb_movies -t web --platforms ios,android,web
```

### What Was Created

The entire Flutter project skeleton with:

- **Stacked architecture** files (`app.dart`, `app.locator.dart`, `app.router.dart`)
- **Responsive views** (`.mobile.dart`, `.tablet.dart`, `.desktop.dart` for each screen)
- **Basic UI components** (dialogs, bottom sheets, hover effects for web)
- **Testing infrastructure** (golden tests, viewmodel tests)

### Key Files Generated

```
lib/
├── app/
│   ├── app.dart              # App setup, register services
│   ├── app.locator.dart      # Dependency injection setup
│   ├── app.router.dart       # Navigation (auto-generated)
│   └── app.bottomsheets.dart # Bottom sheets registry
├── ui/
│   ├── common/               # App colors, strings, helpers
│   ├── views/                # Home, startup, unknown views
│   └── widgets/              # Reusable widgets
└── main.dart                 # App entry point
```

### What You Learned (Architecture & Setup)

- Setting up Stacked for MVVM in Flutter
- Responsive architecture with separate view files
- Dependency injection setup with `get_it`

---

## Phase 2: Networking & Environment Setup (Commits 2-4)

**Commit:** `c247cbe - update readme` (documentation)

**Commit:** `c39c62a - added network with dio, implement env, update readme`

### 2.1 Add Dependencies

```yaml
# pubspec.yaml
dependencies:
  dio: ^5.0.0           # HTTP client
  flutter_dotenv: ^5.0.0 # Environment variables
  logger: ^1.0.0        # Logging
```

### 2.2 Environment Configuration

Create `.env` file in project root:

```env
TMDB_API_KEY=your_api_key_here
TMDB_BASE_URL=https://api.themoviedb.org/3
TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p
```

Load it in `main.dart`:

```dart
void main() async {
  await dotenv.load();
  runApp(const MyApp());
}
```

### 2.3 API Client Setup (`lib/network/api_client.dart`)

```dart
class ApiClient {
  late Dio dio;
  
  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: dotenv.env['TMDB_BASE_URL']!,
      queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
    ));
    
    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(PrettyDioLogger());
  }
}
```

### 2.4 Error Handling System

Created exception hierarchy:

- `AppException` (base)
- `NetworkException` (no internet, timeout)
- `ServerException` (4xx, 5xx errors)

### What You Learned

- Secure API key management with `flutter_dotenv`
- Dio interceptors for headers and logging
- Custom exception handling for API errors

---

## Phase 3: App Branding & Theming (Commits 5-7)

**Commit:** `3b4270c - feat: change app package name`

Change package name using `change_app_package_name`:

```bash
dart run change_app_package_name:main com.persadaditya.tmdbmovies
```

**Commit:** `a6e07c5 - change app icon`

Using `flutter_launcher_icons`:

```yaml
# flutter_launcher_icons.yaml
flutter_launcher_icons:
  image_path: "assets/logo_cinemax.png"
  android: true
  ios: true
  web:
    generate: true
```

Run:

```bash
dart run flutter_launcher_icons:generate
```

**Commit:** `a9fd6bc - implement theme, font, color, style for base`

### Theme Configuration (`lib/ui/common/app_theme.dart`)

```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
```

### What You Learned (Branding & Theme)

- Changing package name for app store distribution
- Custom app icons for all platforms
- Centralized theme management with custom fonts

---

## Phase 4: Authentication Flow (Commits 8-11)

**Commit:** `a016b73 - fix startup view with logo`

Startup view checks auth state and navigates accordingly:

```dart
class StartupViewModel extends BaseViewModel {
  Future<void> checkAuth() async {
    final hasSession = await _localDataService.hasSession();
    if (hasSession) {
      _navigationService.replaceWithDashboardView();
    } else {
      _navigationService.replaceWithSignInView();
    }
  }
}
```

**Commit:** `c64eaac - implement sign in view and make text-field as design style`

### Custom TextField Widget (`lib/ui/widgets/common/app_text_field/`)

```dart
class AppTextField extends ViewModelWidget<AppTextFieldModel> {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  
  @override
  Widget build(BuildContext context, model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            errorText: model.errorMessage,
          ),
        ),
      ],
    );
  }
}
```

**Commit:** `bfe1b96 - implement launch url for sign up at tmdb`

Launch external URL:

```dart
Future<void> signUp() async {
  const url = 'https://www.themoviedb.org/signup';
  if (await canLaunch(url)) {
    await launch(url);
  }
}
```

**Commit:** `c6d3286 - implement sign in and add local data for session`

### Authentication Models

```dart
// Token response from TMDB API
class TokenResponse {
  bool success;
  String requestToken;
}

// Session after validation
class SessionResponse {
  bool success;
  String sessionId;
}
```

### Auth Service (`lib/services/auth_service.dart`)

```dart
class AuthService {
  Future<String> createRequestToken() async {
    final response = await _apiClient.dio.get('/authentication/token/new');
    return TokenResponse.fromJson(response.data).requestToken;
  }
  
  Future<String> createSession(String requestToken) async {
    final response = await _apiClient.dio.post(
      '/authentication/session/new',
      data: {'request_token': requestToken},
    );
    return SessionResponse.fromJson(response.data).sessionId;
  }
}
```

### Local Data Service (`lib/services/local_data_service.dart`)

```dart
class LocalDataService {
  Future<void> saveSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', sessionId);
  }
  
  Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('session_id');
  }
}
```

### What You Learned (Authentication)

- TMDB authentication flow (request token → user validation → session)
- SharedPreferences for local data persistence
- Custom reusable form fields with error handling
- Launching external URLs from Flutter

---

## Phase 5: Main Dashboard (Commit 12)

**Commit:** `1694692 - implement dashboard view wiht menu after login`

### Dashboard Structure

```dart
class DashboardViewModel extends ReactiveViewModel {
  int currentIndex = 0;
  
  final List<MenuItem> menuItems = [
    MenuItem(icon: Icons.home, label: 'Home', view: HomeView()),
    MenuItem(icon: Icons.search, label: 'Search', view: SearchView()),
    MenuItem(icon: Icons.favorite, label: 'Wishlist', view: WishlistView()),
    MenuItem(icon: Icons.person, label: 'Profile', view: ProfileView()),
  ];
  
  void setIndex(int index) {
    currentIndex = index;
    rebuildViews();
  }
}
```

### Custom Navigation Widget

```dart
class CustomNavItem extends StatelessWidget {
  final MenuItem item;
  final bool isSelected;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => viewModel.setIndex(index),
      child: Column(
        children: [
          Icon(item.icon, color: isSelected ? Colors.blue : Colors.grey),
          Text(item.label),
          if (isSelected) Container(height: 2, width: 20, color: Colors.blue),
        ],
      ),
    );
  }
}
```

### What You Learned (Navigation)

- Bottom navigation bar with multiple views
- State management with `rebuildViews()`
- Creating reusable menu components

---

## Phase 6: User Profile & Home Screen (Commits 13-14)

**Commit:** `d71dff6 - implement sign in feature`

### User Model

```dart
class User {
  int id;
  String username;
  String name;
  String avatarPath;
  String? bio;
}
```

### User Service

```dart
class UserService {
  Future<User> getAccountDetails(String sessionId) async {
    final response = await _apiClient.dio.get(
      '/account',
      queryParameters: {'session_id': sessionId},
    );
    return User.fromJson(response.data);
  }
}
```

**Commit:** `ee4bff0 - implement home at dashboard`

### Movie Model

```dart
class Movie {
  int id;
  String title;
  String overview;
  String posterPath;
  String backdropPath;
  double voteAverage;
  DateTime releaseDate;
  List<int> genreIds;
}
```

### Movie Service

```dart
class MovieService {
  Future<PaginatedResponse<Movie>> getNowPlaying({int page = 1}) async {
    final response = await _apiClient.dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    return PaginatedResponse.fromJson(response.data, Movie.fromJson);
  }
}
```

### Home ViewModel

```dart
class HomeViewModel extends ReactiveViewModel {
  List<Movie> nowPlaying = [];
  List<Movie> popular = [];
  List<Movie> topRated = [];
  List<Movie> upcoming = [];
  
  Future<void> loadMovies() async {
    nowPlaying = await _movieService.getNowPlaying().results;
    popular = await _movieService.getPopular().results;
    topRated = await _movieService.getTopRated().results;
    upcoming = await _movieService.getUpcoming().results;
    rebuildViews();
  }
}
```

### What You Learned (User Profile & Home)

- Fetching user account data from TMDB
- Creating data models with JSON serialization
- Building paginated API responses
- Loading multiple movie categories in parallel

---

## Phase 7: Movie Detail View (Commit 15)

**Commit:** `874fe5d - implement movie detail`

### Movie Detail ViewModel

```dart
class MovieViewModel extends FutureViewModel<MovieDetail> {
  final int movieId;
  
  @override
  Future<MovieDetail> futureToRun() => _movieService.getMovieDetail(movieId);
  
  Future<void> addToWishlist() async {
    await _movieService.addToWatchlist(movieId);
    showMessage('Added to wishlist!');
  }
}
```

### Item Movie Widget

```dart
class ItemMovie extends StatelessWidget {
  final Movie movie;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService().navigateToMovieView(id: movie.id),
      child: Card(
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: movie.posterPath),
            Text(movie.title, maxLines: 2),
            Row(children: [
              Icon(Icons.star, color: Colors.amber),
              Text('${movie.voteAverage}/10'),
            ]),
          ],
        ),
      ),
    );
  }
}
```

### What You Learned (Movie Details)

- `FutureViewModel` for async data loading
- Navigation with parameters
- Cached network images for posters
- Building reusable movie cards

---

## Phase 8: Enhanced Features (Commits 16-19)

**Commit:** `d898083 - added credit feature in movie detail view`

### Cast Model

```dart
class Cast {
  int id;
  String name;
  String character;
  String profilePath;
}
```

### Cast Service

```dart
Future<List<Cast>> getMovieCredits(int movieId) async {
  final response = await _apiClient.dio.get('/movie/$movieId/credits');
  return (response.data['cast'] as List).map((c) => Cast.fromJson(c)).toList();
}
```

**Commit:** `a5e8ffe - fix: some view, feat: added images gallery from movie`

### Gallery Feature

- `gallery_view.dart` - Grid of movie images
- `image_view.dart` - Full-screen image viewer
- Movie image model with backdrops and posters

**Commit:** `fee43d4 - feat: added review fix: simplify movie service`

### Review System

```dart
class Review {
  String author;
  String content;
  double rating;
  DateTime createdAt;
}
```

### Review Widget

Display user reviews with avatars and star ratings.

**Commit:** `d458d71 - feat: added trailer and video player`

### Trailer Integration

```dart
class Trailer {
  String key;  // YouTube video ID
  String name;
  String site; // "YouTube"
  String type; // "Trailer", "Teaser", etc.
}
```

### Video Player View

Using `youtube_player_flutter` package to play trailers.

**Commit:** `82858f7 - feat: implement search view`

### Search Implementation

```dart
class SearchViewModel extends ReactiveViewModel {
  String query = '';
  List<Movie> results = [];
  
  Future<void> search() async {
    if (query.length >= 3) {
      results = await _movieService.searchMovies(query);
      rebuildViews();
    }
  }
}
```

**Commit:** `adfc05f - fix: touchup` (final polish)

---

## Testing Strategy

Your project includes comprehensive testing:

### Golden Tests

```dart
testWidgets('HomeView golden test', (tester) async {
  await tester.pumpWidget(MyApp());
  await expectLater(find.byType(HomeView), matchesGoldenFile('golden/home_view.png'));
});
```

### ViewModel Tests

```dart
group('HomeViewModel', () {
  test('loadMovies fetches movies from service', () async {
    final model = HomeViewModel();
    await model.loadMovies();
    expect(model.nowPlaying.isNotEmpty, true);
  });
});
```

### Service Tests

Mocked Dio responses for API service testing.

---

## Key Takeaways from Your Development Journey

1. **Stacked MVVM Structure** - Clean separation with views, viewmodels, and services
2. **Responsive Design** - Separate files for mobile, tablet, and desktop layouts
3. **Environment Variables** - Secure API key management
4. **Error Handling** - Custom exception hierarchy with Dio interceptors
5. **Local Storage** - SharedPreferences for session management
6. **Reusable Components** - Custom text fields, movie cards, navigation items
7. **Testing** - Golden tests, viewmodel tests, and service tests
8. **Feature Progression** - Auth → Dashboard → Home → Details → Enhanced features

---

## Running the Complete Project

```bash
# Clone your repository
git clone https://github.com/persadaditya/tmdb_movies_mvvm.git

# Install dependencies
flutter pub get

# Setup environment
echo "TMDB_API_KEY=your_key_here" > .env

# Run the app
flutter run

# Run tests
flutter test

# Update golden tests
flutter test --update-goldens
```

---

This tutorial follows **your exact commit history**, showing how you progressively built a production-ready Flutter app. Each commit added meaningful functionality, and you maintained good practices like:

- Separate commits for each feature
- Adding tests alongside features
- Responsive UI for multiple platforms
- Clean MVVM architecture with Stacked

Would you like me to expand on any specific section or create a video script based on this tutorial?
