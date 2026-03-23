import 'dart:convert';

class MovieImage {
  List<Image>? backdrops;
  int? id;
  List<Image>? logos;
  List<Image>? posters;

  MovieImage({
    this.backdrops,
    this.id,
    this.logos,
    this.posters,
  });

  MovieImage copyWith({
    List<Image>? backdrops,
    int? id,
    List<Image>? logos,
    List<Image>? posters,
  }) =>
      MovieImage(
        backdrops: backdrops ?? this.backdrops,
        id: id ?? this.id,
        logos: logos ?? this.logos,
        posters: posters ?? this.posters,
      );

  factory MovieImage.fromRawJson(String str) =>
      MovieImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieImage.fromJson(Map<String, dynamic> json) => MovieImage(
        backdrops: json["backdrops"] == null
            ? []
            : List<Image>.from(
                json["backdrops"]!.map((x) => Image.fromJson(x))),
        id: json["id"],
        logos: json["logos"] == null
            ? []
            : List<Image>.from(json["logos"]!.map((x) => Image.fromJson(x))),
        posters: json["posters"] == null
            ? []
            : List<Image>.from(json["posters"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "backdrops": backdrops == null
            ? []
            : List<dynamic>.from(backdrops!.map((x) => x.toJson())),
        "id": id,
        "logos": logos == null
            ? []
            : List<dynamic>.from(logos!.map((x) => x.toJson())),
        "posters": posters == null
            ? []
            : List<dynamic>.from(posters!.map((x) => x.toJson())),
      };
}

class Image {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Image({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Image copyWith({
    double? aspectRatio,
    int? height,
    String? iso6391,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  }) =>
      Image(
        aspectRatio: aspectRatio ?? this.aspectRatio,
        height: height ?? this.height,
        iso6391: iso6391 ?? this.iso6391,
        filePath: filePath ?? this.filePath,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        width: width ?? this.width,
      );

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        aspectRatio: json["aspect_ratio"]?.toDouble(),
        height: json["height"],
        iso6391: json["iso_639_1"],
        filePath: json["file_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "height": height,
        "iso_639_1": iso6391,
        "file_path": filePath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
