import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/app_theme.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

import 'profile_viewmodel.dart';

class ProfileViewMobile extends ViewModelWidget<ProfileViewModel> {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    var avatar = viewModel.user.avatar?.tmdb?.avatarPath;
    var gravatar = viewModel.user.avatar?.gravatar?.hash;
    var imageUrl = avatar != null
        ? 'https://image.tmdb.org/t/p/w500$avatar'
        : 'https://secure.gravatar.com/avatar/$gravatar.jpg?s=200';
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(imageUrl),
              ),
              horizontalSpaceMedium,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viewModel.user.username ?? 'no name',
                      style: Theme.of(context).textTheme.titleLarge),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Text(viewModel.user.id.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  )),
                      horizontalSpaceSmall,
                      Text(
                          '|  ${viewModel.user.iso6391} - ${viewModel.user.iso31661}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: kcVeryLightGrey,
                                  )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          verticalSpaceMedium,
          verticalSpaceMedium,
          Text(
            'Account',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          verticalSpaceSmall,
          ListTile(
            onTap: viewModel.editProfile,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.manage_accounts),
            ),
            title: Text(
              'Edit Profile',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          ListTile(
            onTap: viewModel.changePassword,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.lock_reset),
            ),
            title: Text(
              'Change Password',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          ListTile(
            onTap: viewModel.deleteAccount,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.person_remove),
            ),
            title: Text(
              'Delete Account',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          verticalSpaceMedium,
          Text(
            'General',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          verticalSpaceSmall,
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.language),
            ),
            title: Text(
              'Language',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Default - English',
              style: textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          ListTile(
            onTap: viewModel.toCountrySelection,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.flag),
            ),
            title: Text(
              'Country',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              viewModel.country?.nativeName ?? 'Unknown',
              style: textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          ListTile(
            onTap: viewModel.toPrivacyPolicyPage,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.privacy_tip_rounded),
            ),
            title: Text(
              'Privacy Policy',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          ListTile(
            onTap: viewModel.toTermsOfUsePage,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.help_rounded),
            ),
            title: Text(
              'Terms of Use',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          ListTile(
            onTap: viewModel.toDMCAPolicyPage,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              foregroundColor: kcLightGrey,
              child: Icon(Icons.info),
            ),
            title: Text(
              'DMCA Policy',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: appColorPrimaryBlueAccent,
            ),
          ),
          verticalSpaceMedium,
          ElevatedButton(
              style: tertiaryButtonStyle,
              onPressed: () {
                viewModel.logout();
              },
              child: const Text('Sign Out')),
          verticalSpaceMedium,
          verticalSpaceMedium
        ],
      ),
    );
  }
}
