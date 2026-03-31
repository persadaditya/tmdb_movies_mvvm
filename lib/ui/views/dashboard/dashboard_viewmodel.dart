import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/ui/views/dashboard/model/menu_item.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  final pageController = PageController();
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
