class TypeDossierModel {
  final int? nbreDossier;
  final String? libelle;
  final int? typeDossier;

  TypeDossierModel({
    this.nbreDossier,
    this.libelle,
    this.typeDossier,
  });

  factory TypeDossierModel.fromJson(Map<String, dynamic> json) {
    return TypeDossierModel(
      nbreDossier: json['nbre_dossier'] is int
          ? json['nbre_dossier']
          : int.tryParse(json['nbre_dossier']?.toString() ?? ''),
      libelle: json['libelle'],
      typeDossier: json['type_dossier'] is int
          ? json['type_dossier']
          : int.tryParse(json['type_dossier']?.toString() ?? ''),
    );
  }
}
