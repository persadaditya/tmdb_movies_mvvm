import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoViewModel extends BaseViewModel {
  final String youtubeId;

  VideoViewModel({required this.youtubeId});

  late YoutubePlayerController controller;

  bool _isReady = false;
  bool get isReady => _isReady;

  double _volume = 100;
  double get volume => _volume;
  set volume(double value) {
    _volume = value;
    controller.setVolume(value.round());
    notifyListeners();
  }

  bool _muted = false;
  bool get muted => _muted;
  set muted(bool value) {
    if (value) {
      controller.mute();
    } else {
      controller.unMute();
    }
    _muted = value;
    notifyListeners();
  }

  YoutubeMetaData _metaData = const YoutubeMetaData();
  YoutubeMetaData get metaData => _metaData;

  PlayerState playerState = PlayerState.unknown;

  void init() {
    controller = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true, // important for autoplay
      ),
    );

    controller.addListener(_listener);
  }

  void _listener() {
    if (_isReady && !controller.value.isFullScreen) {
      playerState = controller.value.playerState;
      _metaData = controller.value.metaData;
      notifyListeners();
    }
  }

  void onReady() {
    _isReady = true;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    controller.dispose();
    super.dispose();
  }
}
