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
- **Nested navigation with children routes** (NEW)

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

### Key Learnings: Architecture & Setup

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

### Key Learnings: Networking & Security

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

### Key Learnings: Branding & UI

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

### Key Learnings: Authentication & Forms

- Creating custom form widgets with validation
- Launching external URLs
- TMDB authentication flow (request token → session)
- Local storage for session persistence

---

## Phase 5: Web Routing with Path Parameters (NEW - Uncommitted Changes)

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

### Key Learnings: Web Routing

- Configuring path parameters in Stacked routes
- Using `@pathParam` annotation to access URL parameters
- Navigating to routes with path parameters
- Benefits of path parameters for web applications
- Handling direct URL navigation in Flutter web

---

## Phase 6: Nested Navigation with Children Routes (NEW)

**Feature:** Implementing nested navigation using children routes instead of page views

### 6.1 The Problem with PageView Navigation

The previous implementation used a `PageView` or custom `Navigator` widget to switch between dashboard screens. This approach had limitations:

- No proper URL routing for web
- Browser back/forward buttons didn't work correctly
- Hard to share specific dashboard pages
- Complex state management

### 6.2 Solution: Nested Routes with Children

The new implementation uses Stacked's nested routing feature:

In `lib/app/app.dart`:

```dart
CustomRoute(page: DashboardView, path: '/', children: [
  CustomRoute(page: HomeView, path: 'home', initial: true),
  CustomRoute(page: SearchView, path: 'search'),
  CustomRoute(page: ProfileView, path: 'profile'),
  CustomRoute(page: WishlistView, path: 'wishlist'),
]),
```

### 6.3 Dashboard View with NestedRouter

In `lib/ui/views/dashboard/dashboard_view.mobile.dart`:

```dart
class DashboardViewMobile extends ViewModelWidget<DashboardViewModel> {
  const DashboardViewMobile({super.key});

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      body: const NestedRouter(),
      bottomNavigationBar: NavigationBar(
          selectedIndex: viewModel.currentIndex,
          onDestinationSelected: (index) => viewModel.setIndex(index),
          destinations: viewModel.menuItems
              .map((menu) => CustomNavItem(
                    icon: menu.icon,
                    label: menu.title,
                    isSelected: viewModel.currentIndex ==
                        viewModel.menuItems.indexOf(menu),
                    onTap: () {
                      var index = viewModel.menuItems.indexOf(menu);
                      viewModel.onTapMenu(menu);
                    },
                  ))
              .toList()),
    );
  }
}
```

### 6.4 Dashboard ViewModel Navigation

In `lib/ui/views/dashboard/dashboard_viewmodel.dart`:

```dart
class DashboardViewModel extends IndexTrackingViewModel {
  final _router = locator<RouterService>();

  List<MenuItem> menuItems = [
    MenuItem('Home', Icons.home),
    MenuItem('Search', Icons.search),
    MenuItem('Wishlist', Icons.bookmark_add),
    MenuItem('Profile', Icons.person),
  ];

  Future<void> onTapMenu(MenuItem menu) async {
    setIndex(menuItems.indexOf(menu));
    switch (menu.title) {
      case 'Home':
        await _router.navigateToHomeView();
      case 'Search':
        await _router.navigateToSearchView();
      case 'Wishlist':
        await _router.navigateToWishlistView();
      case 'Profile':
        await _router.navigateToProfileView();
    }
  }
}
```

### 6.5 URL Structure with Nested Routes

The nested routing creates clean URL structures:

- `/` or `/home` - Home page
- `/search` - Search page  
- `/profile` - Profile page
- `/wishlist` - Wishlist page

### 6.6 Benefits of Nested Routing

1. **Proper Web URLs**: Each dashboard page has its own URL
2. **Browser Navigation**: Back/forward buttons work correctly
3. **Shareable Links**: Users can share specific dashboard pages
4. **State Preservation**: Each route maintains its own state
5. **SEO Friendly**: Search engines can index individual pages

### 6.7 How NestedRouter Works

The `NestedRouter()` widget is a Stacked component that:

1. **Automatically Renders Child Routes**: When placed in a parent view (like `DashboardView`), it automatically renders the appropriate child route based on the current URL. For example:
   - URL `/` → Renders `HomeView` (the initial child)
   - URL `/search` → Renders `SearchView`
   - URL `/profile` → Renders `ProfileView`

2. **Manages Navigation State**: The `NestedRouter` maintains the navigation stack for child routes independently. Users can navigate between dashboard pages without losing the parent context.

3. **Integrates with Stacked Navigation**: It works seamlessly with Stacked's navigation system. When you call `navigationService.navigateTo(...)` to a child route, `NestedRouter` updates accordingly.

4. **Preserves Parent UI**: The parent view (dashboard layout with bottom navigation) remains visible while child content changes. This creates a native app-like experience.

5. **Handles Platform Differences**: On mobile, it integrates with bottom navigation; on desktop/web, it can work with side navigation or tabs while maintaining the same routing structure.

**Implementation in DashboardView**:

```dart
// In dashboard_view.mobile.dart
class DashboardViewMobile extends ViewModelWidget<DashboardViewModel> {
  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      body: const NestedRouter(),  // ← This renders child routes
      bottomNavigationBar: NavigationBar(...),
    );
  }
}
```

The `NestedRouter()` widget reads the route configuration from `app.dart` and renders the appropriate child view based on the URL path segment after the parent route.

### Key Learnings: Nested Navigation

1. **Children Routes vs PageView**: Children routes provide proper web URLs and browser navigation, while PageView was limited to in-memory state.

2. **Stacked NestedRouter**: The `NestedRouter()` widget automatically handles child route rendering when you define children in route configuration.

3. **URL Structure**: Parent routes act as URL prefixes (`/`), and child routes append their paths (`/search`, `/profile`, etc.).

4. **Navigation Patterns**: Use `navigationService.navigateTo(...)` with child route names, and the `NestedRouter` handles the visual transition.

5. **State Management**: Each child route maintains its own ViewModel state, independent of other dashboard pages.

## Conclusion

This tutorial has documented the evolution of the TMDB Movies Flutter application from initial setup through advanced routing patterns. The key architectural improvements include:

1. **Stacked MVVM Architecture**: Clean separation of business logic (ViewModels) from UI (Views)
2. **Path Parameter Routing**: Web-friendly URLs with `@pathParam` for dynamic content
3. **Nested Navigation**: Proper hierarchical routing with `NestedRouter()` and children routes

The transition from PageView-based navigation to nested routing represents a significant improvement in web compatibility, URL structure, and user experience. Each dashboard page now has its own shareable URL, browser navigation works correctly, and the application follows web standards while maintaining a native mobile feel.

These changes make the TMDB Movies application a production-ready Flutter web and mobile app that follows best practices for routing, state management, and user experience.
