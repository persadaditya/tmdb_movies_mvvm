import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/widgets/common/item/item_movie.dart';

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
          child: viewModel.busy('movies')
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : ListView(
                  children: [
                    verticalSpaceLarge,
                    ListTile(
                      leading: CircleAvatar(
                        foregroundImage: CachedNetworkImageProvider(
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
                    ),
                    verticalSpaceMedium,
                    CarouselSlider.builder(
                      carouselController: viewModel.sliderController,
                      itemBuilder: (context, index, realIndex) {
                        var movie = viewModel.movies[index];
                        return InkWell(
                          onTap: () {
                            viewModel.navigateToMovie(movie.id ?? 0);
                          },
                          child: Material(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${movie.backdropPath ?? movie.posterPath ?? ''}',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Center(
                                    child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: appColorPrimaryDark),
                                        child: const Icon(Icons.movie)),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  alignment: Alignment.bottomLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        movie.title ?? '',
                                        style: textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('on ${movie.releaseDateFormatted}'),
                                      verticalSpaceSmall,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: viewModel.movies.length,
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            viewModel.setIndex(index);
                          },
                          height: 180,
                          aspectRatio: 9 / 16,
                          viewportFraction: 0.78,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800, seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          scrollDirection: Axis.horizontal),
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: viewModel.movies.asMap().entries.map((entry) {
                        var selected = viewModel.currentIndex == entry.key;
                        return GestureDetector(
                          onTap: () => viewModel.sliderController
                              .animateToPage(entry.key),
                          child: Container(
                            width: selected ? 36.0 : 8.00,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                borderRadius: selected
                                    ? BorderRadius.circular(12.0)
                                    : null,
                                shape: selected
                                    ? BoxShape.rectangle
                                    : BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? appColorPrimaryBlueAccent
                                        : Colors.black)
                                    .withValues(alpha: selected ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                    verticalSpaceMedium,
                    _buildMostPopularMovies(viewModel, context),
                    verticalSpaceMedium,
                    _buildTopRatedMovies(viewModel, context)
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildMostPopularMovies(
      HomeViewModel viewModel, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Most Popular',
                style: textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Expanded(child: Container()),
            Text('See all',
                style: textTheme.bodyLarge?.copyWith(
                    color: appColorPrimaryBlueAccent,
                    fontWeight: FontWeight.bold))
          ],
        ),
        verticalSpaceMedium,
        SizedBox(
          height: 220,
          child: ListView.builder(
              itemCount: viewModel.moviesByPopular.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var movie = viewModel.moviesByPopular[index];
                return ItemMovie(
                  movie: movie,
                  genres: viewModel.genres,
                );
              }),
        ),
      ],
    );
  }

  Widget _buildTopRatedMovies(HomeViewModel viewModel, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        children: [
          Text('Top Rated',
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          Expanded(child: Container()),
          Text('See all',
              style: textTheme.bodyLarge?.copyWith(
                  color: appColorPrimaryBlueAccent,
                  fontWeight: FontWeight.bold))
        ],
      ),
      verticalSpaceMedium,
      SizedBox(
        height: 220,
        child: ListView.builder(
            itemCount: viewModel.moviesByTopRated.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var movie = viewModel.moviesByTopRated[index];
              return ItemMovie(
                movie: movie,
                genres: viewModel.genres,
                withRating: true,
              );
            }),
      )
    ]);
  }
}
