class Paginated<T> {
  final Dates? dates;
  final int? page;
  final List<T>? results;
  final int? totalPages;
  final int? totalResults;

  Paginated({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return Paginated<T>(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'],
      results: (json['results'] as List?)?.map((e) => fromJsonT(e)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results?.map((e) => toJsonT(e)).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  Paginated<T> copyWith({
    Dates? dates,
    int? page,
    List<T>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return Paginated<T>(
      dates: dates ?? this.dates,
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

class Dates {
  final String? maximum;
  final String? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'],
      minimum: json['minimum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }

  Dates copyWith({
    String? maximum,
    String? minimum,
  }) {
    return Dates(
      maximum: maximum ?? this.maximum,
      minimum: minimum ?? this.minimum,
    );
  }
}
