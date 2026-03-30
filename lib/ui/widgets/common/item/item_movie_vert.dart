import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
    var parseDate = DateTime.tryParse(movie.releaseDate ?? '');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: appColorTextBlack),
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(6)),
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
        Flexible(
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
            Row(
              children: [
                if (parseDate != null)
                  _iconText(context, Icons.calendar_month_outlined,
                      DateFormat("MMM yyyy").format(parseDate)),
                Expanded(child: Container()),
                if (movie.voteAverage != null) ...[
                  horizontalSpaceSmall,
                  _iconText(context, Icons.star_outline,
                      movie.voteAverage?.toStringAsFixed(1) ?? '0.0',
                      color: appColorSecOrange),
                ]
              ],
            ),
            if (genres.isNotEmpty) ...[
              verticalSpaceSmall,
              verticalSpaceTiny,
              Text(getGenresName(movie.genreIds ?? []),
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w300),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ] else ...[
              Text('No genres available',
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w300),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
            verticalSpaceSmall,
            verticalSpaceTiny,
            Row(
              children: [
                Text('${movie.popularity?.toStringAsFixed(1) ?? '0.0'}%',
                    style: textTheme.bodyMedium?.copyWith(
                      color: appColorPrimaryBlueAccent,
                    )),
                horizontalSpaceSmall,
                Expanded(
                  child: LinearProgressIndicator(
                    value: (movie.popularity ?? 0) / 100,
                    color: appColorPrimaryBlueAccent,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor:
                        appColorPrimaryBlueAccent.withValues(alpha: 0.3),
                  ),
                ),
              ],
            )
          ],
        ))
      ],
    );
  }

  Widget _iconText(BuildContext context, IconData icon, String text,
      {Color? color}) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color ?? appColorPrimaryBlueAccent,
          size: 16,
        ),
        horizontalSpaceTiny,
        Text(text,
            style: textTheme.bodyMedium?.copyWith(
              color: color ?? appColorPrimaryBlueAccent,
            ),
            maxLines: 1)
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
