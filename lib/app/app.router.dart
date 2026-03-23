// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i14;
import 'package:stacked/stacked.dart' as _i13;
import 'package:stacked_services/stacked_services.dart' as _i12;

import '../model/movie_image.dart' as _i15;
import '../ui/views/dashboard/dashboard_view.dart' as _i4;
import '../ui/views/gallery/gallery_view.dart' as _i10;
import '../ui/views/home/home_view.dart' as _i2;
import '../ui/views/image/image_view.dart' as _i9;
import '../ui/views/movie/movie_view.dart' as _i8;
import '../ui/views/profile/profile_view.dart' as _i6;
import '../ui/views/search/search_view.dart' as _i5;
import '../ui/views/sign_in/sign_in_view.dart' as _i3;
import '../ui/views/startup/startup_view.dart' as _i1;
import '../ui/views/unknown/unknown_view.dart' as _i11;
import '../ui/views/wishlist/wishlist_view.dart' as _i7;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i12.StackedService.navigatorKey);

class StackedRouterWeb extends _i13.RootStackRouter {
  StackedRouterWeb({_i14.GlobalKey<_i14.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignInViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.SignInView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.DashboardView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SearchViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.SearchView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfileView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    WishlistViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.WishlistView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MovieViewRoute.name: (routeData) {
      final args = routeData.argsAs<MovieViewArgs>();
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.MovieView(
          key: args.key,
          id: args.id,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ImageViewRoute.name: (routeData) {
      final args = routeData.argsAs<ImageViewArgs>();
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.ImageView(
          key: args.key,
          url: args.url,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    GalleryViewRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryViewArgs>();
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.GalleryView(
          key: args.key,
          movieImage: args.movieImage,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UnknownViewRoute.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i11.UnknownView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i13.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i13.RouteConfig(
          SignInViewRoute.name,
          path: '/sign-in-view',
        ),
        _i13.RouteConfig(
          DashboardViewRoute.name,
          path: '/dashboard-view',
        ),
        _i13.RouteConfig(
          SearchViewRoute.name,
          path: '/search-view',
        ),
        _i13.RouteConfig(
          ProfileViewRoute.name,
          path: '/profile-view',
        ),
        _i13.RouteConfig(
          WishlistViewRoute.name,
          path: '/wishlist-view',
        ),
        _i13.RouteConfig(
          MovieViewRoute.name,
          path: '/movie-view',
        ),
        _i13.RouteConfig(
          ImageViewRoute.name,
          path: '/image-view',
        ),
        _i13.RouteConfig(
          GalleryViewRoute.name,
          path: '/gallery-view',
        ),
        _i13.RouteConfig(
          UnknownViewRoute.name,
          path: '/404',
        ),
        _i13.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/404',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i13.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i13.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i3.SignInView]
class SignInViewRoute extends _i13.PageRouteInfo<void> {
  const SignInViewRoute()
      : super(
          SignInViewRoute.name,
          path: '/sign-in-view',
        );

  static const String name = 'SignInView';
}

/// generated route for
/// [_i4.DashboardView]
class DashboardViewRoute extends _i13.PageRouteInfo<void> {
  const DashboardViewRoute()
      : super(
          DashboardViewRoute.name,
          path: '/dashboard-view',
        );

  static const String name = 'DashboardView';
}

/// generated route for
/// [_i5.SearchView]
class SearchViewRoute extends _i13.PageRouteInfo<void> {
  const SearchViewRoute()
      : super(
          SearchViewRoute.name,
          path: '/search-view',
        );

  static const String name = 'SearchView';
}

/// generated route for
/// [_i6.ProfileView]
class ProfileViewRoute extends _i13.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: '/profile-view',
        );

  static const String name = 'ProfileView';
}

/// generated route for
/// [_i7.WishlistView]
class WishlistViewRoute extends _i13.PageRouteInfo<void> {
  const WishlistViewRoute()
      : super(
          WishlistViewRoute.name,
          path: '/wishlist-view',
        );

  static const String name = 'WishlistView';
}

/// generated route for
/// [_i8.MovieView]
class MovieViewRoute extends _i13.PageRouteInfo<MovieViewArgs> {
  MovieViewRoute({
    _i14.Key? key,
    required int id,
  }) : super(
          MovieViewRoute.name,
          path: '/movie-view',
          args: MovieViewArgs(
            key: key,
            id: id,
          ),
        );

  static const String name = 'MovieView';
}

class MovieViewArgs {
  const MovieViewArgs({
    this.key,
    required this.id,
  });

  final _i14.Key? key;

  final int id;

  @override
  String toString() {
    return 'MovieViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i9.ImageView]
class ImageViewRoute extends _i13.PageRouteInfo<ImageViewArgs> {
  ImageViewRoute({
    _i14.Key? key,
    required String url,
  }) : super(
          ImageViewRoute.name,
          path: '/image-view',
          args: ImageViewArgs(
            key: key,
            url: url,
          ),
        );

  static const String name = 'ImageView';
}

class ImageViewArgs {
  const ImageViewArgs({
    this.key,
    required this.url,
  });

  final _i14.Key? key;

  final String url;

  @override
  String toString() {
    return 'ImageViewArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [_i10.GalleryView]
class GalleryViewRoute extends _i13.PageRouteInfo<GalleryViewArgs> {
  GalleryViewRoute({
    _i14.Key? key,
    required _i15.MovieImage movieImage,
  }) : super(
          GalleryViewRoute.name,
          path: '/gallery-view',
          args: GalleryViewArgs(
            key: key,
            movieImage: movieImage,
          ),
        );

  static const String name = 'GalleryView';
}

class GalleryViewArgs {
  const GalleryViewArgs({
    this.key,
    required this.movieImage,
  });

  final _i14.Key? key;

  final _i15.MovieImage movieImage;

  @override
  String toString() {
    return 'GalleryViewArgs{key: $key, movieImage: $movieImage}';
  }
}

/// generated route for
/// [_i11.UnknownView]
class UnknownViewRoute extends _i13.PageRouteInfo<void> {
  const UnknownViewRoute()
      : super(
          UnknownViewRoute.name,
          path: '/404',
        );

  static const String name = 'UnknownView';
}

extension RouterStateExtension on _i12.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToHomeView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSignInView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SignInViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToDashboardView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const DashboardViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSearchView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SearchViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToWishlistView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const WishlistViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToMovieView({
    _i14.Key? key,
    required int id,
    void Function(_i13.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      MovieViewRoute(
        key: key,
        id: id,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToImageView({
    _i14.Key? key,
    required String url,
    void Function(_i13.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      ImageViewRoute(
        key: key,
        url: url,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToGalleryView({
    _i14.Key? key,
    required _i15.MovieImage movieImage,
    void Function(_i13.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      GalleryViewRoute(
        key: key,
        movieImage: movieImage,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToUnknownView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSignInView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SignInViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithDashboardView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const DashboardViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSearchView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SearchViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithWishlistView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const WishlistViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMovieView({
    _i14.Key? key,
    required int id,
    void Function(_i13.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      MovieViewRoute(
        key: key,
        id: id,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithImageView({
    _i14.Key? key,
    required String url,
    void Function(_i13.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      ImageViewRoute(
        key: key,
        url: url,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithGalleryView({
    _i14.Key? key,
    required _i15.MovieImage movieImage,
    void Function(_i13.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      GalleryViewRoute(
        key: key,
        movieImage: movieImage,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithUnknownView(
      {void Function(_i13.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }
}
