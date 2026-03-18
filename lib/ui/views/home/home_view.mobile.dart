import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                opacity: 0.6,
                                image: CachedNetworkImageProvider(
                                    'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                movie.title ?? '',
                                style: textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text('on ${movie.releaseDateFormatted}'),
                              verticalSpaceSmall,
                            ],
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
                return Container(
                  height: 200,
                  margin: const EdgeInsets.only(right: 10),
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                          color: appColorPrimarySoft,
                        ),
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              movie.title ?? '',
                              style: textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpaceTiny,
                            Text(viewModel.getGenresName(movie.genreIds ?? []),
                                style: textTheme.bodySmall?.copyWith(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            verticalSpaceTiny,
                          ],
                        ),
                      )
                    ],
                  ),
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
              return Stack(
                alignment: const Alignment(0.75, -0.95),
                children: [
                  Container(
                    height: 210,
                    margin: const EdgeInsets.only(right: 10),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                            color: appColorPrimarySoft,
                          ),
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                movie.title ?? '',
                                style: textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpaceTiny,
                              Text(
                                  viewModel.getGenresName(movie.genreIds ?? []),
                                  style: textTheme.bodySmall?.copyWith(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              verticalSpaceTiny,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: appColorSecOrange,
                    child: Text(
                      '${movie.voteAverage?.toStringAsFixed(1)}',
                      style: textTheme.bodyLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }),
      )
    ]);
  }
}
