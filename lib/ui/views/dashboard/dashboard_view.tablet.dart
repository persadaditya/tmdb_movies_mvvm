import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/constant/vectors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

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
                        viewModel.onTapMenu(menu);
                        Navigator.pop(context);
                      },
                    ))
                .toList()
          ],
        ),
      ),
      body: const NestedRouter(),
    );
  }
}
