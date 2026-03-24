import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/model/production_company.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/app_theme.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:tmdb_movies/ui/widgets/common/item/item_cast.dart';
import 'package:tmdb_movies/ui/widgets/common/item/item_company.dart';
import 'package:tmdb_movies/ui/widgets/common/item/item_movie.dart';
import 'package:tmdb_movies/ui/widgets/common/item/item_review.dart';

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
                  opacity: 0.10,
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
                      viewModel.movie.voteAverage?.toStringAsFixed(1) ?? '',
                      Icons.star),
                ],
              ),
              verticalSpaceMedium,
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Container()),
                      ElevatedButton.icon(
                          style: secondaryButtonStyle,
                          onPressed: () {
                            viewModel.onTapTrailer();
                          },
                          icon: const Icon(
                            Icons.movie,
                            color: kcWhite,
                          ),
                          label: const Text('Trailers')),
                      horizontalSpaceMedium,
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.download)),
                      ),
                      horizontalSpaceMedium,
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.share)),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Original Title',
                    style: textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  verticalSpaceSmall,
                  Text(viewModel.movie.originalTitle ?? '',
                      style: textTheme.bodyLarge),
                  verticalSpaceMedium,
                  Text(
                    'Genres',
                    style: textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  verticalSpaceSmall,
                  Text(
                      viewModel.movie.genres
                              ?.map((genre) => genre.name)
                              .join(', ') ??
                          '',
                      style: textTheme.bodyLarge),
                  verticalSpaceMedium,
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
                  verticalSpaceMedium,
                  _buildTitle(context, 'Cast'),
                  verticalSpaceSmall,
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                        itemCount: viewModel.casts.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var cast = viewModel.casts[index];
                          return ItemCast(cast: cast);
                        }),
                  ),
                  verticalSpaceMedium,
                  _buildTitle(context, 'Crews'),
                  verticalSpaceSmall,
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                        itemCount: viewModel.crews.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var cast = viewModel.crews[index];
                          return ItemCast(cast: cast);
                        }),
                  ),
                  verticalSpaceMedium,
                  _buildTitle(context, 'Gallery', onTapMore: () {
                    viewModel.onTapMoreImages();
                  }),
                  verticalSpaceSmall,
                  viewModel.busy('images')
                      ? const Center(
                          child: SizedBox(
                              height: 200, child: CircularProgressIndicator()))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                          itemCount: viewModel.images.length > 6
                              ? 6
                              : viewModel.images.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var image = viewModel.images[index];
                            return InkWell(
                              onTap: () {
                                if (image.filePath == null) return;
                                viewModel.onTapImage(
                                    'https://image.tmdb.org/t/p/w500${image.filePath}');
                              },
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${image.filePath}',
                                imageBuilder: (context, imageProvider) =>
                                    AspectRatio(
                                  aspectRatio: image.aspectRatio ?? 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey,
                                  ),
                                ),
                                fit: BoxFit.contain,
                              ),
                            );
                          }),
                  verticalSpaceMedium,
                  verticalSpaceSmall,
                  _buildTitle(context, 'Companies'),
                  verticalSpaceSmall,
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      var company = viewModel.movie.productionCompanies?[index];
                      return ItemCompany(
                          company: company ?? ProductionCompany());
                    },
                    itemCount: viewModel.movie.productionCompanies?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  verticalSpaceMedium,
                  verticalSpaceSmall,
                  _buildTitle(context, 'Reviews'),
                  verticalSpaceSmall,
                  verticalSpaceTiny,
                  viewModel.busy('reviews')
                      ? const Center(
                          child: SizedBox(
                              height: 200, child: CircularProgressIndicator()))
                      : viewModel.reviews.isEmpty
                          ? const Text('No reviews yet')
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.reviews.length,
                              itemBuilder: (context, index) {
                                var review = viewModel.reviews[index];
                                return ItemReview(review: review);
                              },
                              separatorBuilder: (context, index) {
                                return verticalSpaceMedium;
                              }),
                  verticalSpaceMedium,
                  verticalSpaceSmall,
                  _buildTitle(context, 'Related Movies'),
                  verticalSpaceMedium,
                  viewModel.busy('movies')
                      ? const Center(
                          child: SizedBox(
                              height: 200, child: CircularProgressIndicator()))
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 140,
                            mainAxisSpacing: 8,
                            childAspectRatio: 3 / 5,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: viewModel.movies.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var movie = viewModel.movies[index];
                            return ItemMovie(
                              movie: movie,
                              genres: const [],
                            );
                          })
                ],
              ),
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

  Widget _buildTitle(BuildContext context, String title,
      {Function()? onTapMore}) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        horizontalSpaceMedium,
        if (onTapMore != null) ...[
          TextButton(
              onPressed: () {
                onTapMore();
              },
              child: const Text(
                'See all',
              ))
        ],
      ],
    );
  }
}
