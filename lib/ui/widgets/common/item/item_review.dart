import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_movies/model/review.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

class ItemReview extends StatelessWidget {
  const ItemReview({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (review.authorDetails?.avatarPath != null) ...[
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    'https://image.tmdb.org/t/p/w500${review.authorDetails?.avatarPath ?? ''}'),
              ),
            ] else ...[
              const CircleAvatar(
                  child: Icon(Icons.person, color: Colors.white)),
            ],
            if (review.authorDetails?.rating != null) ...[
              verticalSpaceSmall,
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  horizontalSpaceTiny,
                  Text(
                    review.authorDetails?.rating.toString() ?? '',
                  ),
                ],
              )
            ]
          ],
        ),
        horizontalSpaceSmall,
        horizontalSpaceTiny,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(review.author ?? ''),
              Text(
                  DateFormat('MMM dd, yyyy')
                      .format(review.createdAt ?? DateTime.now()),
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
              verticalSpaceSmall,
              Text(review.content ?? '', style: textTheme.bodySmall),
            ],
          ),
        )
      ],
    );
  }
}
