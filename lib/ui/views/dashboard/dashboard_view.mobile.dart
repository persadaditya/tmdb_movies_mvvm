import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/widgets/common/custom_nav_item.dart';

import 'dashboard_viewmodel.dart';

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
