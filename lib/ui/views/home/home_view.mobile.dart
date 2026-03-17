import 'package:tmdb_movies/model/user.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpaceLarge,
              ListTile(
                leading: CircleAvatar(
                  foregroundImage: NetworkImage(
                      'https://secure.gravatar.com/avatar/${viewModel.user?.avatar?.gravatar?.hash}.jpg?s=200'),
                ),
                title: Text(
                  viewModel.user?.username ?? '',
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Let’s stream your favorite movie'),
                trailing: const Icon(Icons.favorite,
                    color: appColorPrimaryBlueAccent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
