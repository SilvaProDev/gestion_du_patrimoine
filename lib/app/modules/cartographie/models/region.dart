class RegionModel {
  final int? id;
  final String? libelleRegion;

  RegionModel({
    this.id,
    this.libelleRegion,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleRegion: json['libelle_region'],
     
    );
  }
}
