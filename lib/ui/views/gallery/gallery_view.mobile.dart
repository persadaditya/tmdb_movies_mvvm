import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/constant/vectors.dart';
import 'package:tmdb_movies/model/movie_image.dart' as movie_image;
import 'package:tmdb_movies/ui/common/ui_helpers.dart';

import 'gallery_viewmodel.dart';

class GalleryViewMobile extends ViewModelWidget<GalleryViewModel> {
  const GalleryViewMobile({super.key});

  @override
  Widget build(BuildContext context, GalleryViewModel viewModel) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Movie Gallery'),
            bottom: const TabBar(tabs: [
              Tab(text: 'Backdrop'),
              Tab(text: 'Logo'),
              Tab(text: 'Poster'),
            ]),
          ),
          body: TabBarView(children: [
            _buildGridView(
                context, viewModel.movieImage.backdrops ?? [], viewModel),
            _buildGridView(
                context, viewModel.movieImage.logos ?? [], viewModel),
            _buildGridView(
                context, viewModel.movieImage.posters ?? [], viewModel),
          ]),
        ));
  }

  Widget _buildGridView(BuildContext context, List<movie_image.Image> images,
      GalleryViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return images.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Vectors.empty),
              verticalSpaceMedium,
              Text(
                'There is no image',
                style: textTheme.titleLarge,
              ),
            ],
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              var image = images[index];
              var url = 'https://image.tmdb.org/t/p/w500${image.filePath}';
              return InkWell(
                onTap: () {
                  viewModel.onImageTap(url);
                },
                child: CachedNetworkImage(
                    imageUrl: url,
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
              );
            },
          );
  }
}
