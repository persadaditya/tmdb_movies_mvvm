class ProductionCompany {
  final int? id;
  final String? name;
  final String? logoPath;
  final String? originCountry;

  ProductionCompany({
    this.id,
    this.name,
    this.logoPath,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      name: json['name'],
      logoPath: json['logo_path'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo_path': logoPath,
        'origin_country': originCountry,
      };
}
