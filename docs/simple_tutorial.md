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
- **Web-friendly routing with path parameters** (NEW)

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

```folder
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
API_KEY=your_api_key_here
```

Load it in `main.dart`:

```dart
void main() async {
  await dotenv.load();
  runApp(const MyApp());
}
```

### 2.3 API Client Setup (`lib/network/header_interceptor.dart`)

```dart
class HeaderInterceptor extends InterceptorsWrapper {
  final String _apiKey = dotenv.env['API_KEY'] ?? '';
  final logger = getLogger('interceptor');

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_apiKey",
    });

    handler.next(options);
  }

  ///... onError goes here
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
ThemeData buildTheme(Brightness brightness) {
  ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: appColorPrimaryDark,
    surface: appColorPrimaryDark,
    onSurface: appColorTextWhite,
    primary: appColorPrimaryBlueAccent,
    onPrimary: appColorTextWhiteGrey,
    primaryContainer: appColorPrimarySoft,
    onPrimaryContainer: appColorPrimaryBlueAccent,
    secondary: appColorSecOrange,
    onSecondary: appColorTextWhite,
    secondaryContainer: appColorPrimarySoft,
    onSecondaryContainer: appColorSecOrange,
    brightness: brightness,
  );
  final baseTheme =
      ThemeData.from(colorScheme: colorScheme, useMaterial3: true);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.montserratTextTheme(baseTheme.textTheme).copyWith(
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 28,
      ),
      bodyMedium:
          GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: appColorPrimaryBlueAccent, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: appColorTextWhiteGrey, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: appColorError, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: appColorError, width: 2),
        ),
        filled: true,
        fillColor: appColorPrimarySoft,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: TextStyle(color: appColorTextWhiteGrey)),
  );
}
```

### What You Learned (Branding & Theme)

- Changing Flutter app package name
- Generating app icons for all platforms
- Creating a custom theme with Google Fonts
- Consistent input field styling

---

## Phase 4: Authentication Flow (Commits 8-11)

**Commit:** `a016b73 - fix startup view with logo`

Startup view checks auth state and navigates accordingly:

```dart
class StartupViewModel extends BaseViewModel {
  final _routerService = locator<RouterService>();
  final _authService = locator<AuthService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    await Future.delayed(const Duration(seconds: 4));
    if (await _authService.isSignedIn()) {
      await _routerService.replaceWith(const DashboardViewRoute());
      return;
    }
    await _routerService.replaceWith(const SignInViewRoute());
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
///ui_helpers.dart
Future<void> openUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}

///sign_in_viewmodel.dart
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
  final Dio _client = ApiClient().dio;
  final LocalDataService _localDataService = locator<LocalDataService>();

  Future<TokenResponse> createRequestToken() async {
    final response = await _client.get('/authentication/token/new');
    return TokenResponse.fromJson(response.data);
  }

  Future<SessionResponse> createSession(String requestToken) async {
    final response = await _client.post('/authentication/session/new', data: {
      'request_token': requestToken,
    });
    return SessionResponse.fromJson(response.data);
  }

  Future<void> signOut() async {
    final sessionId = await _localDataService.getSessionId();
    if (sessionId != null) {
      await _client.delete('/authentication/session', data: {
        'session_id': sessionId,
      });
    }
    await _localDataService.clearSession();
  }
}
```

### What You Learned (Authentication)

- Creating custom form widgets with validation
- Launching external URLs
- TMDB authentication flow (request token → session)
- Local storage for session persistence

---

## Phase 5: Web Routing with Path Parameters (NEW)

**Feature:** Implementing proper web routing with path parameters for shareable URLs

### 5.1 Understanding Path Parameters vs Query Parameters

For web applications, you have two options for passing data in URLs:

1. **Path Parameters**: `/movie/123` (clean, SEO-friendly)
2. **Query Parameters**: `/movie?id=123` (flexible, multiple parameters)

The current implementation uses **path parameters** for better web compatibility.

### 5.2 Route Configuration with Path Parameters

In `lib/app/app.dart`:

```dart
@StackedApp(
  logger: StackedLogger(),
  routes: [
    // ... other routes
    CustomRoute(page: MovieView, path: '/movie/:id'),
    CustomRoute(page: MoviesView, path: '/movies'),
    // ... more routes
  ],
)
```

Key points:

- `:id` defines a path parameter

### 5.3 Accessing Path Parameters in Views

In `lib/ui/views/movie/movie_view.dart`:

```dart
class MovieView extends StackedView<MovieViewModel> {
  const MovieView({super.key, @pathParam required this.id});

  final String id;

  @override
  Widget builder(
    BuildContext context,
    MovieViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.busy('movie') || viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ScreenTypeLayout.builder(
              mobile: (_) => const MovieViewMobile(),
              tablet: (_) => const MovieViewTablet(),
              desktop: (_) => const MovieViewDesktop(),
            ),
    );
  }

  @override
  void onViewModelReady(MovieViewModel viewModel) async {
    await viewModel.loadMovie();
    await viewModel.loadCasts();
    await viewModel.loadImages();
    await viewModel.loadReviews();
    await viewModel.loadSimilarMovies();
    super.onViewModelReady(viewModel);
  }

  @override
  MovieViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MovieViewModel(id: int.tryParse(id) ?? 0);
}
```

### 5.4 Navigating to Path Parameter Routes

In `lib/ui/views/home/home_viewmodel.dart`:

```dart
void navigateToMovie(int id) {
  var route = MovieViewRoute(id: '$id');
  _routerService.navigateTo(route);
}
```

The `MovieViewRoute` class is auto-generated by Stacked and handles the path parameter conversion.

### 5.5 Getting Path from URL (Direct Navigation)

For web applications, users can directly navigate to URLs like `https://yourapp.com/movie/123`. The Stacked router automatically:

1. Parses the URL path `/movie/123`
2. Extracts the `id` parameter (`123`)
3. Passes it to the `MovieView` constructor via `@pathParam`

### 5.6 Benefits of Path Parameters for Web

1. **SEO Friendly**: Search engines can crawl individual movie pages
2. **Shareable URLs**: Users can share direct links to specific movies
3. **Browser History**: Proper back/forward navigation works
4. **Bookmarkable**: Users can bookmark specific movie pages

### 5.7 Handling Invalid Path Parameters

The current implementation includes error handling:

```dart
MovieViewModel(id: int.tryParse(id) ?? 0);
```

This converts the string ID to an integer, defaulting to 0 if parsing fails. In production, you might want to add better error handling.

### What You Learned (Web Routing)

- Configuring path parameters in Stacked routes
- Using `@pathParam` annotation to access URL parameters
- Navigating to routes with path parameters
- Benefits of path parameters for web applications
- Handling direct URL navigation in Flutter web

---

## Phase 6: Dashboard & Navigation (Commits 12-14)

**Commit:** `e5c5c4e - implement dashboard view`

Dashboard with navigation drawer:

```dart
class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      drawer: const DashboardDrawer(),
      body: Row(
        children: [
          if (!viewModel.isMobile) const DashboardSidebar(),
          Expanded(
            child: Navigator(
              key: viewModel.navigatorKey,
              onGenerateRoute: viewModel.onGenerateRoute,
            ),
          ),
        ],
      ),
    );
  }
}
```

**Commit:** `a5c0f9c - implement home view`

Home view with movie carousel and categories:

```dart
class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero carousel
            CarouselSlider.builder(
              itemCount: viewModel.movies.length,
              options: CarouselOptions(
                height: 500,
                viewportFraction: 1.0,
                autoPlay: true,
              ),
              itemBuilder: (context, index, realIndex) {
                final movie = viewModel.movies[index];
                return MovieHeroCard(movie: movie);
              },
            ),
            
            // Movie categories
            MovieCategorySection(
              title: 'Popular Movies',
              movies: viewModel.moviesByPopular,
              onSeeAll: () => viewModel.navigateToMovies(MovieType.popular),
            ),
            
            MovieCategorySection(
              title: 'Top Rated Movies',
              movies: viewModel.moviesByTopRated,
              onSeeAll: () => viewModel.navigateToMovies(MovieType.topRated),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Commit:** `f3a3e2e - implement movie item widget`

Reusable movie card widget:

```dart
class ItemMovie extends StatelessWidget {
  final Movie movie;
  
  const ItemMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: Container(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                width: 150,
                height: 225,
                fit: BoxFit.cover,
              ),
            ),
            
            SizedBox(height: 8),
            
            // Movie title
            Text(
              movie.title ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Rating
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text('${movie.voteAverage?.toStringAsFixed(1) ?? '0.0'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### What You Learned (Dashboard Layout)

- Creating dashboard layouts with navigation
- Implementing carousels with
