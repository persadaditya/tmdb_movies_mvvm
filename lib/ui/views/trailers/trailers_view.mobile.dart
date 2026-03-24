import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'trailers_viewmodel.dart';

class TrailersViewMobile extends ViewModelWidget<TrailersViewModel> {
  const TrailersViewMobile({super.key});

  @override
  Widget build(BuildContext context, TrailersViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trailers'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          itemCount: viewModel.trailers.length,
          itemBuilder: (context, index) {
            var trailer = viewModel.trailers[index];
            return InkWell(
              onTap: () {
                viewModel.onTapTrailer(trailer);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    imageUrl: getThumbnail(trailer.key ?? ''),
                    imageBuilder: (context, imageProvider) => AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              opacity: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    trailer.name ?? '',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (trailer.publishedAt != null) ...[
                    Text(
                      DateFormat('MMMM dd, yyyy').format(trailer.publishedAt!),
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  verticalSpaceTiny,
                  Text(trailer.site ?? ''),
                  verticalSpaceMedium,
                  verticalSpaceSmall,
                ],
              ),
            );
          }),
    );
  }

  String getThumbnail(String key) {
    return 'https://img.youtube.com/vi/$key/0.jpg';
  }
}
