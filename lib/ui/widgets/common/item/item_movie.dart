import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tmdb_movies/app/app.locator.dart';
import 'package:tmdb_movies/app/app.router.dart';
import 'package:tmdb_movies/model/genre.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

class ItemMovie extends StatelessWidget {
  const ItemMovie({
    super.key,
    required this.movie,
    this.withRating = false,
    this.genres = const [],
  });

  final Movie movie;
  final bool withRating;
  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        locator<RouterService>().navigateToMovieView(id: movie.id ?? 0);
      },
      child: Stack(
        alignment: const Alignment(0.75, -0.95),
        children: [
          Container(
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
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            )),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                    color: appColorPrimarySoft,
                  ),
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        movie.title ?? '',
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: genres.isEmpty ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpaceTiny,
                      if (genres.isNotEmpty) ...[
                        Text(getGenresName(movie.genreIds ?? []),
                            style: textTheme.bodySmall?.copyWith(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                      verticalSpaceTiny,
                    ],
                  ),
                )
              ],
            ),
          ),
          if (withRating) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: appColorSecGreen,
              child: Text(
                '${movie.voteAverage?.toStringAsFixed(1)}',
                style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ]
        ],
      ),
    );
  }

  String getGenresName(List<int> ids) {
    return genres
        .where((genre) => ids.contains(genre.id))
        .map((genre) => genre.name)
        .join(', ');
  }
}
