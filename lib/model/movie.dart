import 'package:intl/intl.dart';
import 'package:tmdb_movies/model/genre.dart';
import 'package:tmdb_movies/model/production_company.dart';
import 'package:tmdb_movies/model/production_country.dart';
import 'package:tmdb_movies/model/spoken_language.dart';

class Movie {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;

  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  // 🔥 NEW (detail fields)
  final int? budget;
  final int? revenue;
  final int? runtime;
  final String? status;
  final String? tagline;
  final String? homepage;
  final String? imdbId;

  final List<Genre>? genres;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final List<SpokenLanguage>? spokenLanguages;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,

    // detail
    this.budget,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.homepage,
    this.imdbId,
    this.genres,
    this.productionCompanies,
    this.productionCountries,
    this.spokenLanguages,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: (json['genre_ids'] as List?)?.map((e) => e as int).toList(),

      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],

      // detail
      budget: json['budget'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
      homepage: json['homepage'],
      imdbId: json['imdb_id'],

      genres: (json['genres'] as List?)?.map((e) => Genre.fromJson(e)).toList(),

      productionCompanies: (json['production_companies'] as List?)
          ?.map((e) => ProductionCompany.fromJson(e))
          .toList(),

      productionCountries: (json['production_countries'] as List?)
          ?.map((e) => ProductionCountry.fromJson(e))
          .toList(),

      spokenLanguages: (json['spoken_languages'] as List?)
          ?.map((e) => SpokenLanguage.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'budget': budget,
      'revenue': revenue,
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'homepage': homepage,
      'imdb_id': imdbId,
      'genres': genres?.map((e) => e.toJson()).toList(),
      'production_companies':
          productionCompanies?.map((e) => e.toJson()).toList(),
      'production_countries':
          productionCountries?.map((e) => e.toJson()).toList(),
      'spoken_languages': spokenLanguages?.map((e) => e.toJson()).toList(),
    };
  }

  Movie copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    int? budget,
    int? revenue,
    int? runtime,
    String? status,
    String? tagline,
    String? homepage,
    String? imdbId,
    List<Genre>? genres,
    List<ProductionCompany>? productionCompanies,
    List<ProductionCountry>? productionCountries,
    List<SpokenLanguage>? spokenLanguages,
  }) {
    return Movie(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      budget: budget ?? this.budget,
      revenue: revenue ?? this.revenue,
      runtime: runtime ?? this.runtime,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      homepage: homepage ?? this.homepage,
      imdbId: imdbId ?? this.imdbId,
      genres: genres ?? this.genres,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
    );
  }

  DateTime? get releaseDateParsed {
    if (releaseDate == null) return null;
    return DateTime.tryParse(releaseDate ?? '');
  }

  String? get releaseDateFormatted {
    if (releaseDate == null) return null;
    var parsed = DateTime.tryParse(releaseDate ?? '');
    if (parsed == null) return null;
    return DateFormat("MMMM d, yyyy").format(parsed);
  }

  String? get genreFromIds {
    if (genres == null) return null;
    return genres?.map((e) => e.name).join(', ');
  }
}
