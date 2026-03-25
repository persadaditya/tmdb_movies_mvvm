import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:tmdb_movies/ui/widgets/common/item/item_movie_vert.dart';

import 'search_viewmodel.dart';

class SearchViewMobile extends ViewModelWidget<SearchViewModel> {
  const SearchViewMobile({super.key});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            verticalSpaceMedium,
            verticalSpaceSmall,
            TextField(
              controller: viewModel.controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: appColorTextBlack,
                focusColor: Colors.grey.shade100,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
                hintText: 'Search movie here',
                suffixIcon: viewModel.isSearch
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          viewModel.controller.clear();
                          viewModel.searchResults.clear();
                          viewModel.toggleSearch();
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.all(8.0),
              ),
              onChanged: (value) {
                viewModel.toggleSearch();
              },
              onSubmitted: (value) {
                if (value.isEmpty) return;
                viewModel.searchMovies(value);
              },
              textInputAction: TextInputAction.search,
            ),
            verticalSpaceMedium,
            verticalSpaceSmall,
            _buildSearchResult(context, viewModel)
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResult(BuildContext context, SearchViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : viewModel.isSearch
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  verticalSpaceMedium,
                  Text('Search Result',
                      style: Theme.of(context).textTheme.titleMedium),
                  verticalSpaceMedium,
                  ...viewModel.searchResults.map((movie) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              viewModel.onTapMovie(movie.id ?? 0);
                            },
                            child: ItemMovieVert(
                              movie: movie,
                              genres: viewModel.genres,
                            ),
                          ),
                          verticalSpaceMedium,
                        ],
                      ))
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Latest Movie', style: textTheme.titleLarge),
                  verticalSpaceMedium,
                  InkWell(
                      onTap: () {
                        viewModel.onTapMovie(viewModel.latestMovie.id ?? 0);
                      },
                      child: ItemMovieVert(
                        movie: viewModel.latestMovie,
                        genres: viewModel.genres,
                      ))
                ],
              );
  }
}
