class ActiviteModel {
  final int? id;
  final String? libelleActivite;

  ActiviteModel({
    this.id,
    this.libelleActivite,
  });

  factory ActiviteModel.fromJson(Map<String, dynamic> json) {
    return ActiviteModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleActivite: json['libelle_activite'],
     
    );
  }
}
