import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies/model/cast_crew.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

class ItemCast extends StatelessWidget {
  const ItemCast({super.key, required this.cast});
  final Cast cast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (cast.profilePath != null) ...[
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  'https://image.tmdb.org/t/p/w500${cast.profilePath}'),
            ),
          ],
          horizontalSpaceSmall,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cast.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium,
              ),
              Text(cast.character ?? cast.department?.name ?? '',
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
          horizontalSpaceMedium,
        ],
      ),
    );
  }
}
