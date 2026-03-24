import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_viewmodel.dart';

class VideoViewMobile extends ViewModelWidget<VideoViewModel> {
  const VideoViewMobile({super.key});

  @override
  Widget build(BuildContext context, VideoViewModel viewModel) {
    return SafeArea(
      child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            onReady: () {
              viewModel.onReady();
            },
            controller: viewModel.controller,
            showVideoProgressIndicator: true,
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  viewModel.metaData.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: Icon(
                  viewModel.muted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () {
                  viewModel.muted = !viewModel.muted;
                },
              ),
            ],
          ),
          builder: (context, player) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Movie Trailer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: ListView(
                  children: [
                    player,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.metaData.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          verticalSpaceMedium,
                          _text('Channel', viewModel.metaData.author),
                          verticalSpaceSmall,
                          _text('Video Id', viewModel.metaData.videoId),
                          verticalSpaceSmall,
                          _text('Title', viewModel.metaData.title),
                        ],
                      ),
                    ),
                  ],
                ));
          }),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: kcWhite,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: kcWhite,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
