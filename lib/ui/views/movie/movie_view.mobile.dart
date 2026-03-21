import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

import 'movie_viewmodel.dart';

class MovieViewMobile extends ViewModelWidget<MovieViewModel> {
  const MovieViewMobile({super.key});

  @override
  Widget build(BuildContext context, MovieViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          viewModel.movie.title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.2,
                  image: CachedNetworkImageProvider(
                      'https://image.tmdb.org/t/p/w500${viewModel.movie.posterPath ?? ''}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListView(
            children: [
              verticalSpaceMedium,
              Center(
                child: SizedBox(
                  width: screenWidth(context) * 0.6,
                  child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              'https://image.tmdb.org/t/p/w500${viewModel.movie.posterPath ?? ''}'),
                          fit: BoxFit.cover,
                        ),
                      ))),
                ),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconText(
                      viewModel.movie.releaseDateParsed?.year.toString() ?? '',
                      Icons.calendar_month),
                  iconText(
                      '${viewModel.movie.runtime == 0 ? '' : '${viewModel.movie.runtime?.toString()}'} ${viewModel.movie.runtime == 0 ? 'Unreleased' : 'minutes'}',
                      Icons.schedule),
                  iconText(
                      viewModel.movie.genres
                              ?.map((genre) => genre.name ?? '')
                              .toList()
                              .join(', \n') ??
                          '',
                      Icons.theaters_outlined),
                ],
              ),
              verticalSpaceMedium,
              ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      'Story Line',
                      style: textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    verticalSpaceSmall,
                    Wrap(
                      runSpacing: 8,
                      children: [
                        Text(
                          viewModel.movie.overview ?? '',
                          style: textTheme.bodyLarge,
                          maxLines: viewModel.seeMore ? null : 3,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.seeMore = !viewModel.seeMore;
                            viewModel.notifyListeners();
                          },
                          child:
                              Text('See ${viewModel.seeMore ? 'less' : 'more'}',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: appColorPrimaryBlueAccent,
                                    fontWeight: FontWeight.bold,
                                  )),
                        )
                      ],
                    ),
                  ]),
              verticalSpaceLarge,
            ],
          ),
        ],
      ),
    );
  }

  Widget iconText(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon),
        horizontalSpaceSmall,
        Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
