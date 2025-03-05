class DistrictModel {
  final int? id;
  final String? libelleDistrict;

  DistrictModel({
    this.id,
    this.libelleDistrict,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleDistrict: json['libelle_district'],
     
    );
  }
}
