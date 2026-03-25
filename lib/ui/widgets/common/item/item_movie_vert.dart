import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb_movies/constant/vectors.dart';
import 'package:tmdb_movies/model/genre.dart';
import 'package:tmdb_movies/model/movie.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

class ItemMovieVert extends StatelessWidget {
  const ItemMovieVert({super.key, required this.movie, this.genres = const []});

  final Movie movie;
  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: appColorTextBlack),
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(10)),
              );
            },
            errorWidget: (context, url, error) =>
                SvgPicture.asset(Vectors.logo, width: 20, height: 20),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        horizontalSpaceSmall,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(movie.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    )),
            verticalSpaceSmall,
            _iconText(context, Icons.calendar_month,
                movie.releaseDateParsed?.year.toString() ?? '-'),
            verticalSpaceSmall,
            _iconText(context, Icons.watch,
                '${movie.runtime ?? 0} ${movie.runtime != null ? 'Minutes' : ''}'),
            if (genres.isNotEmpty) ...[
              verticalSpaceSmall,
              Text(getGenresName(movie.genreIds ?? []),
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w300),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ],
        ))
      ],
    );
  }

  Widget _iconText(BuildContext context, IconData icon, String text) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(
          icon,
          color: appColorPrimaryBlueAccent,
          size: 16,
        ),
        horizontalSpaceTiny,
        Expanded(
          child: Text(text,
              style: textTheme.bodyMedium?.copyWith(
                color: appColorPrimaryBlueAccent,
              ),
              maxLines: 1),
        )
      ],
    );
  }

  String getGenresName(List<int> ids) {
    return genres
        .where((genre) => ids.contains(genre.id))
        .map((genre) => genre.name)
        .join(', ');
  }
}
