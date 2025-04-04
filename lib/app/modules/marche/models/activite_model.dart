enum serviceId { sigobe, horsSigobe }

class ActiviteModel {
  final String? libelleActivite;
  final int? serviceId;
  final int? activiteId;
  final int? nbreMarche;
  final int? exercice;
  late final int? sig;

  ActiviteModel({
    this.libelleActivite,
    this.serviceId,
    this.activiteId,
    this.nbreMarche,
    this.exercice,
    this.sig,
  });

  // Factory pour créer une instance à partir du JSON
  factory ActiviteModel.fromJson(Map<String, dynamic> json) {
    return ActiviteModel(
        libelleActivite: json['libelle_activite'],
      serviceId: json['service_id'] is int? json['service_id']
                : int.tryParse(json['service_id']?.toString() ?? ''),
      activiteId: json['activite_id'] is int? json['activite_id']
                : int.tryParse(json['activite_id']?.toString() ?? ''),
      nbreMarche: json['nbre_marche'] is int? json['nbre_marche']
                : int.tryParse(json['nbre_marche']?.toString() ?? ''),
      exercice: json['exo_id'] is int? json['exo_id']
                : int.tryParse(json['exo_id']?.toString() ?? ''),
      sig: json['sig'] is int? json['sig']
                : int.tryParse(json['sig']?.toString() ?? ''),

    
    );
  }
/// Factory pour convertir les données issues de SQLite
  factory ActiviteModel.fromJsonSQLite(Map<String, dynamic> json) {
    print("Conversion depuis SQLite : $json");
    return ActiviteModel(
      activiteId: json['activiteId'],
      libelleActivite: json['libelleActivite'],
      serviceId: json['serviceId'],
      nbreMarche: json['nbreMarche'],
      exercice: json['exercice'],
      sig: json['sig'], // Peut être null
    );
  }
  // Méthode pour convertir une instance de ActiviteModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'libelle_activite': libelleActivite,
      'type_gestion': serviceId,
      'service_id': activiteId,
      'nbre_marche': nbreMarche,
      'exo_id': exercice,
    };
  }

  // Méthode pour convertir en format compatible SQLite
  Map<String, dynamic> toMap() {
    return {
      'activiteId': activiteId,
      'libelleActivite': libelleActivite,
      'serviceId': serviceId,
      'nbreMarche': nbreMarche,
      'exercice': exercice,
      'sig': sig,
    };
  }
}
