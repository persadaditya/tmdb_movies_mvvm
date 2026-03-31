// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i17;
import 'package:stacked/stacked.dart' as _i16;
import 'package:stacked_services/stacked_services.dart' as _i15;

import '../model/movie.dart' as _i19;
import '../model/movie_image.dart' as _i18;
import '../ui/views/dashboard/dashboard_view.dart' as _i4;
import '../ui/views/gallery/gallery_view.dart' as _i10;
import '../ui/views/home/home_view.dart' as _i2;
import '../ui/views/image/image_view.dart' as _i9;
import '../ui/views/movie/movie_view.dart' as _i8;
import '../ui/views/movies/movies_view.dart' as _i13;
import '../ui/views/profile/profile_view.dart' as _i6;
import '../ui/views/search/search_view.dart' as _i5;
import '../ui/views/sign_in/sign_in_view.dart' as _i3;
import '../ui/views/startup/startup_view.dart' as _i1;
import '../ui/views/trailers/trailers_view.dart' as _i11;
import '../ui/views/unknown/unknown_view.dart' as _i14;
import '../ui/views/video/video_view.dart' as _i12;
import '../ui/views/wishlist/wishlist_view.dart' as _i7;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i15.StackedService.navigatorKey);

class StackedRouterWeb extends _i16.RootStackRouter {
  StackedRouterWeb({_i17.GlobalKey<_i17.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignInViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.SignInView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.DashboardView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SearchViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.SearchView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfileView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    WishlistViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.WishlistView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MovieViewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MovieViewArgs>(
          orElse: () => MovieViewArgs(id: pathParams.getString('id')));
      return _i16.CustomPage<dynamic>(
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
      return _i16.CustomPage<dynamic>(
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
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.GalleryView(
          key: args.key,
          movieImage: args.movieImage,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TrailersViewRoute.name: (routeData) {
      final args = routeData.argsAs<TrailersViewArgs>();
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.TrailersView(
          key: args.key,
          movieId: args.movieId,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    VideoViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<VideoViewArgs>(orElse: () => const VideoViewArgs());
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i12.VideoView(
          key: args.key,
          youtubeKey: args.youtubeKey,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MoviesViewRoute.name: (routeData) {
      final args = routeData.argsAs<MoviesViewArgs>();
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.MoviesView(
          key: args.key,
          id: args.id,
          type: args.type,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UnknownViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i14.UnknownView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i16.RouteConfig(
          HomeViewRoute.name,
          path: '/home',
        ),
        _i16.RouteConfig(
          SignInViewRoute.name,
          path: '/sign-in',
        ),
        _i16.RouteConfig(
          DashboardViewRoute.name,
          path: '/',
        ),
        _i16.RouteConfig(
          SearchViewRoute.name,
          path: '/search',
        ),
        _i16.RouteConfig(
          ProfileViewRoute.name,
          path: '/profile',
        ),
        _i16.RouteConfig(
          WishlistViewRoute.name,
          path: '/wishlist',
        ),
        _i16.RouteConfig(
          MovieViewRoute.name,
          path: '/movie/:id',
        ),
        _i16.RouteConfig(
          ImageViewRoute.name,
          path: '/image',
        ),
        _i16.RouteConfig(
          GalleryViewRoute.name,
          path: '/gallery',
        ),
        _i16.RouteConfig(
          TrailersViewRoute.name,
          path: '/trailers',
        ),
        _i16.RouteConfig(
          VideoViewRoute.name,
          path: '/video',
        ),
        _i16.RouteConfig(
          MoviesViewRoute.name,
          path: '/movies',
        ),
        _i16.RouteConfig(
          UnknownViewRoute.name,
          path: '/404',
        ),
        _i16.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/404',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i16.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i16.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i3.SignInView]
class SignInViewRoute extends _i16.PageRouteInfo<void> {
  const SignInViewRoute()
      : super(
          SignInViewRoute.name,
          path: '/sign-in',
        );

  static const String name = 'SignInView';
}

/// generated route for
/// [_i4.DashboardView]
class DashboardViewRoute extends _i16.PageRouteInfo<void> {
  const DashboardViewRoute()
      : super(
          DashboardViewRoute.name,
          path: '/',
        );

  static const String name = 'DashboardView';
}

/// generated route for
/// [_i5.SearchView]
class SearchViewRoute extends _i16.PageRouteInfo<void> {
  const SearchViewRoute()
      : super(
          SearchViewRoute.name,
          path: '/search',
        );

  static const String name = 'SearchView';
}

/// generated route for
/// [_i6.ProfileView]
class ProfileViewRoute extends _i16.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: '/profile',
        );

  static const String name = 'ProfileView';
}

/// generated route for
/// [_i7.WishlistView]
class WishlistViewRoute extends _i16.PageRouteInfo<void> {
  const WishlistViewRoute()
      : super(
          WishlistViewRoute.name,
          path: '/wishlist',
        );

  static const String name = 'WishlistView';
}

/// generated route for
/// [_i8.MovieView]
class MovieViewRoute extends _i16.PageRouteInfo<MovieViewArgs> {
  MovieViewRoute({
    _i17.Key? key,
    required String id,
  }) : super(
          MovieViewRoute.name,
          path: '/movie/:id',
          args: MovieViewArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'MovieView';
}

class MovieViewArgs {
  const MovieViewArgs({
    this.key,
    required this.id,
  });

  final _i17.Key? key;

  final String id;

  @override
  String toString() {
    return 'MovieViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i9.ImageView]
class ImageViewRoute extends _i16.PageRouteInfo<ImageViewArgs> {
  ImageViewRoute({
    _i17.Key? key,
    required String url,
  }) : super(
          ImageViewRoute.name,
          path: '/image',
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

  final _i17.Key? key;

  final String url;

  @override
  String toString() {
    return 'ImageViewArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [_i10.GalleryView]
class GalleryViewRoute extends _i16.PageRouteInfo<GalleryViewArgs> {
  GalleryViewRoute({
    _i17.Key? key,
    required _i18.MovieImage movieImage,
  }) : super(
          GalleryViewRoute.name,
          path: '/gallery',
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

  final _i17.Key? key;

  final _i18.MovieImage movieImage;

  @override
  String toString() {
    return 'GalleryViewArgs{key: $key, movieImage: $movieImage}';
  }
}

/// generated route for
/// [_i11.TrailersView]
class TrailersViewRoute extends _i16.PageRouteInfo<TrailersViewArgs> {
  TrailersViewRoute({
    _i17.Key? key,
    required int movieId,
  }) : super(
          TrailersViewRoute.name,
          path: '/trailers',
          args: TrailersViewArgs(
            key: key,
            movieId: movieId,
          ),
        );

  static const String name = 'TrailersView';
}

class TrailersViewArgs {
  const TrailersViewArgs({
    this.key,
    required this.movieId,
  });

  final _i17.Key? key;

  final int movieId;

  @override
  String toString() {
    return 'TrailersViewArgs{key: $key, movieId: $movieId}';
  }
}

/// generated route for
/// [_i12.VideoView]
class VideoViewRoute extends _i16.PageRouteInfo<VideoViewArgs> {
  VideoViewRoute({
    _i17.Key? key,
    String? youtubeKey,
  }) : super(
          VideoViewRoute.name,
          path: '/video',
          args: VideoViewArgs(
            key: key,
            youtubeKey: youtubeKey,
          ),
        );

  static const String name = 'VideoView';
}

class VideoViewArgs {
  const VideoViewArgs({
    this.key,
    this.youtubeKey,
  });

  final _i17.Key? key;

  final String? youtubeKey;

  @override
  String toString() {
    return 'VideoViewArgs{key: $key, youtubeKey: $youtubeKey}';
  }
}

/// generated route for
/// [_i13.MoviesView]
class MoviesViewRoute extends _i16.PageRouteInfo<MoviesViewArgs> {
  MoviesViewRoute({
    _i17.Key? key,
    int? id,
    required _i19.MovieType type,
  }) : super(
          MoviesViewRoute.name,
          path: '/movies',
          args: MoviesViewArgs(
            key: key,
            id: id,
            type: type,
          ),
        );

  static const String name = 'MoviesView';
}

class MoviesViewArgs {
  const MoviesViewArgs({
    this.key,
    this.id,
    required this.type,
  });

  final _i17.Key? key;

  final int? id;

  final _i19.MovieType type;

  @override
  String toString() {
    return 'MoviesViewArgs{key: $key, id: $id, type: $type}';
  }
}

/// generated route for
/// [_i14.UnknownView]
class UnknownViewRoute extends _i16.PageRouteInfo<void> {
  const UnknownViewRoute()
      : super(
          UnknownViewRoute.name,
          path: '/404',
        );

  static const String name = 'UnknownView';
}

extension RouterStateExtension on _i15.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToHomeView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSignInView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SignInViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToDashboardView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const DashboardViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSearchView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SearchViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToWishlistView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const WishlistViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToMovieView({
    _i17.Key? key,
    required String id,
    void Function(_i16.NavigationFailure)? onFailure,
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
    _i17.Key? key,
    required String url,
    void Function(_i16.NavigationFailure)? onFailure,
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
    _i17.Key? key,
    required _i18.MovieImage movieImage,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      GalleryViewRoute(
        key: key,
        movieImage: movieImage,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToTrailersView({
    _i17.Key? key,
    required int movieId,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      TrailersViewRoute(
        key: key,
        movieId: movieId,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToVideoView({
    _i17.Key? key,
    String? youtubeKey,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      VideoViewRoute(
        key: key,
        youtubeKey: youtubeKey,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToMoviesView({
    _i17.Key? key,
    int? id,
    required _i19.MovieType type,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      MoviesViewRoute(
        key: key,
        id: id,
        type: type,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToUnknownView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSignInView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SignInViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithDashboardView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const DashboardViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSearchView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SearchViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithWishlistView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const WishlistViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMovieView({
    _i17.Key? key,
    required String id,
    void Function(_i16.NavigationFailure)? onFailure,
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
    _i17.Key? key,
    required String url,
    void Function(_i16.NavigationFailure)? onFailure,
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
    _i17.Key? key,
    required _i18.MovieImage movieImage,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      GalleryViewRoute(
        key: key,
        movieImage: movieImage,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithTrailersView({
    _i17.Key? key,
    required int movieId,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      TrailersViewRoute(
        key: key,
        movieId: movieId,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithVideoView({
    _i17.Key? key,
    String? youtubeKey,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      VideoViewRoute(
        key: key,
        youtubeKey: youtubeKey,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMoviesView({
    _i17.Key? key,
    int? id,
    required _i19.MovieType type,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      MoviesViewRoute(
        key: key,
        id: id,
        type: type,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithUnknownView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }
}
