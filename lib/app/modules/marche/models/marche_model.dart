class MarcheModel {
  final int? id;
  final int? exercice;
  final int? activiteId;
  final int? montantMarche;
  final String? libelleProcedure;
  final String? libelleMarche;
  final String? libelleActivite;

  MarcheModel({
    this.id,
    this.exercice,
    this.montantMarche,
    this.activiteId,
    this.libelleMarche,
    this.libelleProcedure,
    this.libelleActivite,
  });

  /// Factory pour créer une instance depuis un JSON
  factory MarcheModel.fromJson(Map<String, dynamic> json) => MarcheModel(
        id: int.tryParse(json['id']?.toString() ?? ''),
        exercice: int.tryParse(json['exo_id']?.toString() ?? ''),
        activiteId: int.tryParse(json['activite_id']?.toString() ?? ''),
        montantMarche: int.tryParse(json['montant_marche']?.toString() ?? ''),
        libelleMarche: json['objet'] as String?,
        libelleProcedure: json['libelle_procedure'] as String?,
        libelleActivite: json['libelle_activite'] as String?,
      );
  // Méthode pour convertir une instance de ActiviteModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'montant_marche': montantMarche,
      'libelle_activite': libelleActivite,
      'libelle_procedure': libelleProcedure,
      'activite_id': activiteId,
      'objet': libelleMarche,
      'exo_id': exercice,
    };
  }
}
