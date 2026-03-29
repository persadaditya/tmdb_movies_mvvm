import 'package:tmdb_movies/network/api_client.dart';
import 'package:tmdb_movies/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:tmdb_movies/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:tmdb_movies/ui/views/home/home_view.dart';
import 'package:tmdb_movies/ui/views/startup/startup_view.dart';
import 'package:tmdb_movies/ui/views/unknown/unknown_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/ui/views/sign_in/sign_in_view.dart';
import 'package:tmdb_movies/services/auth_service.dart';
import 'package:tmdb_movies/services/local_data_service.dart';
import 'package:tmdb_movies/ui/views/dashboard/dashboard_view.dart';
import 'package:tmdb_movies/ui/views/search/search_view.dart';
import 'package:tmdb_movies/ui/views/profile/profile_view.dart';
import 'package:tmdb_movies/ui/views/wishlist/wishlist_view.dart';
import 'package:tmdb_movies/services/user_service.dart';
import 'package:tmdb_movies/services/movie_service.dart';
import 'package:tmdb_movies/ui/views/movie/movie_view.dart';
import 'package:tmdb_movies/services/cast_service.dart';
import 'package:tmdb_movies/ui/views/image/image_view.dart';
import 'package:tmdb_movies/ui/views/gallery/gallery_view.dart';
import 'package:tmdb_movies/services/review_service.dart';
import 'package:tmdb_movies/services/trailer_service.dart';
import 'package:tmdb_movies/ui/views/trailers/trailers_view.dart';
import 'package:tmdb_movies/ui/views/video/video_view.dart';
import 'package:tmdb_movies/ui/bottom_sheets/confirmation/confirmation_sheet.dart';
import 'package:tmdb_movies/services/configuration_service.dart';
import 'package:tmdb_movies/ui/bottom_sheets/countries/countries_sheet.dart';
// @stacked-import

@StackedApp(
  logger: StackedLogger(),
  routes: [
    CustomRoute(page: StartupView, initial: true),
    CustomRoute(page: HomeView),
    CustomRoute(page: SignInView),
    CustomRoute(page: DashboardView),
    CustomRoute(page: SearchView),
    CustomRoute(page: ProfileView),
    CustomRoute(page: WishlistView),
    CustomRoute(page: MovieView),
    CustomRoute(page: ImageView),
    CustomRoute(page: GalleryView),
    CustomRoute(page: TrailersView),
    CustomRoute(page: VideoView),
// @stacked-route

    CustomRoute(page: UnknownView, path: '/404'),

    /// When none of the above routes match, redirect to UnknownView
    RedirectRoute(path: '*', redirectTo: '/404'),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ApiClient),
    LazySingleton(classType: LocalDataService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: MovieService),
    LazySingleton(classType: CastService),
    LazySingleton(classType: ReviewService),
    LazySingleton(classType: TrailerService),
    LazySingleton(classType: ConfigurationService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: ConfirmationSheet),
    StackedBottomsheet(classType: CountriesSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
