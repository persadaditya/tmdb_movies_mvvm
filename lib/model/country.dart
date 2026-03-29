import 'dart:convert';

class Country {
  String? iso31661;
  String? englishName;
  String? nativeName;

  Country({
    this.iso31661,
    this.englishName,
    this.nativeName,
  });

  Country copyWith({
    String? iso31661,
    String? englishName,
    String? nativeName,
  }) =>
      Country(
        iso31661: iso31661 ?? this.iso31661,
        englishName: englishName ?? this.englishName,
        nativeName: nativeName ?? this.nativeName,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        iso31661: json["iso_3166_1"],
        englishName: json["english_name"],
        nativeName: json["native_name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "english_name": englishName,
        "native_name": nativeName,
      };
}
