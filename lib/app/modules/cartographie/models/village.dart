class VillageModel {
  final int? id;
  final String? libelleVillage;

  VillageModel({
    this.id,
    this.libelleVillage,
  });

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleVillage: json['libelle_village'],
     
    );
  }
}
