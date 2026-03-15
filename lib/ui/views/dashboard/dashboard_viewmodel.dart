import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/views/dashboard/model/menu_item.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  final pageController = PageController();

  List<MenuItem> menuItems = [
    MenuItem('Home', Icons.home),
    MenuItem('Search', Icons.search),
    MenuItem('Wishlist', Icons.bookmark_add),
    MenuItem('Profile', Icons.person),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
