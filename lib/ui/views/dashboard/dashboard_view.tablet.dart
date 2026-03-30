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

class DashboardViewTablet extends ViewModelWidget<DashboardViewModel> {
  const DashboardViewTablet({super.key});

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.menuItems[viewModel.currentIndex].title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Vectors.logo),
                    verticalSpaceTiny,
                    Text(
                      'TMDB Movies',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    )
                  ],
                )),
            verticalSpaceSmall,
            ...viewModel.menuItems
                .map((menu) => ListTile(
                      leading: Icon(menu.icon),
                      title: Text(menu.title),
                      selected: viewModel.currentIndex ==
                          viewModel.menuItems.indexOf(menu),
                      onTap: () {
                        var index = viewModel.menuItems.indexOf(menu);
                        viewModel.setIndex(index);
                        viewModel.pageController.jumpToPage(index);
                        Navigator.pop(context);
                      },
                    ))
                .toList()
          ],
        ),
      ),
      body: PageView(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          SearchView(),
          WishlistView(),
          ProfileView()
        ],
      ),
    );
  }
}
