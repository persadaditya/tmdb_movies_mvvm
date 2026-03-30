import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/constant/vectors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:tmdb_movies/ui/views/home/home_view.dart';
import 'package:tmdb_movies/ui/views/profile/profile_view.dart';
import 'package:tmdb_movies/ui/views/search/search_view.dart';
import 'package:tmdb_movies/ui/views/wishlist/wishlist_view.dart';

import 'dashboard_viewmodel.dart';

class DashboardViewDesktop extends ViewModelWidget<DashboardViewModel> {
  const DashboardViewDesktop({super.key});

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with Logo
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Vectors.logo,
                        height: 60,
                        width: 60,
                      ),
                      verticalSpaceTiny,
                      Text(
                        'TMDB Movies',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white24, height: 1),
                verticalSpaceMedium,
                // Menu Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ...viewModel.menuItems.map((menu) {
                        final index = viewModel.menuItems.indexOf(menu);
                        final isSelected = viewModel.currentIndex == index;

                        return ListTile(
                          leading: Icon(
                            menu.icon,
                            color: isSelected ? Colors.white : Colors.white70,
                          ),
                          title: Text(
                            menu.title,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          selectedTileColor:
                              Colors.white.withValues(alpha: 0.2),
                          onTap: () {
                            viewModel.setIndex(index);
                            viewModel.pageController.jumpToPage(index);
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
                // Optional: Footer (e.g., version number)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24),
          Expanded(
            child: PageView(
              controller: viewModel.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeView(),
                SearchView(),
                WishlistView(),
                ProfileView()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
