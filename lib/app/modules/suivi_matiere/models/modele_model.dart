class ModeleArticleModel {
  final int? modeleId;
  final String? libelleModele;

  ModeleArticleModel({required this.modeleId, this.libelleModele});


  factory ModeleArticleModel.fromJson(Map<String, dynamic> json){
      return ModeleArticleModel(
         modeleId: json['modele_id'] is int? json['modele_id']
                : int.tryParse(json['modele_id']?.toString() ?? ''),
        libelleModele: json['libelle_modele'] ?? "",
        );
  }

   Map<String, dynamic> toJson() => {
        "modele_id": modeleId,
        "libelle_modele": libelleModele,
      };
}
