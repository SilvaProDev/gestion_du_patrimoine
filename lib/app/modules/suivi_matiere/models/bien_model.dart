class BienModel {
  final int? id;
  final int? articleId;
  final int? quantite;
  final String? couleur;
  final String? libelleBien;
  final String? numeroSerie;

  BienModel({ 
    this.id,
    this.libelleBien,
    this.couleur,
    this.articleId,
    this.quantite,
    this.numeroSerie,
    });


  factory BienModel.fromJson(Map<String, dynamic> json){
      return BienModel(
         id: json['id'] is int? json['id']
                : int.tryParse(json['id']?.toString() ?? ''),
         articleId: json['article_id'] is int? json['article_id']
                : int.tryParse(json['article_id']?.toString() ?? ''),
         quantite: json['quantite'] is int? json['quantite']
                : int.tryParse(json['quantite']?.toString() ?? ''),
        libelleBien: json['libelle_bien'] ?? "",
        numeroSerie: json['numero_serie'] ?? "",
        couleur: json['couleur'] ?? "",
        );
  }
  
   Map<String, dynamic> toJson() => {
        "id": id,
        "article_id": articleId,
        "libelle_bien": libelleBien,
        "numero_serie": numeroSerie,
      };

}
