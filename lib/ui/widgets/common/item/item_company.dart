import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies/model/production_company.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

class ItemCompany extends StatelessWidget {
  const ItemCompany({super.key, required this.company});

  final ProductionCompany company;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: company.logoPath == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        if (company.logoPath != null) ...[
          Expanded(
              child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${company.logoPath}',
            imageBuilder: (context, imageProvider) => Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                    invertColors: true),
              ),
            ),
          ))
        ],
        verticalSpaceSmall,
        Text(company.name ?? '',
            maxLines: company.logoPath != null ? 1 : 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center),
      ],
    );
  }
}
