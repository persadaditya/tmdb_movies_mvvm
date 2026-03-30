import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:tmdb_movies/ui/widgets/common/item/item_movie_vert.dart';

import 'movies_viewmodel.dart';

class MoviesViewMobile extends ViewModelWidget<MoviesViewModel> {
  const MoviesViewMobile({super.key});

  @override
  Widget build(BuildContext context, MoviesViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.type.name.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                )),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          verticalSpaceSmall,
          if (viewModel.isBusy) ...[
            SizedBox(
              height: screenHeight(context) * 0.8,
              child: const Center(
                child: CircularProgressIndicator(
                  color: appColorPrimaryDark,
                ),
              ),
            )
          ] else ...[
            ...viewModel.movies
                .map((movie) => Column(
                      children: [
                        ItemMovieVert(
                          movie: movie,
                          genres: viewModel.genres
                              .where((genre) =>
                                  movie.genreIds?.contains(genre.id) ?? false)
                              .toList(),
                        ),
                        verticalSpaceSmall,
                        verticalSpaceTiny
                      ],
                    ))
                .toList()
          ],
          verticalSpaceSmall,
          if (viewModel.hasNextPage)
            if (viewModel.busy('loadMore')) ...[
              const CircularProgressIndicator()
            ] else ...[
              ElevatedButton(
                onPressed: () =>
                    viewModel.loadMore(viewModel.id, viewModel.type),
                child: const Text('Load More'),
              )
            ],
          verticalSpaceMedium,
        ],
      ),
    );
  }
}
