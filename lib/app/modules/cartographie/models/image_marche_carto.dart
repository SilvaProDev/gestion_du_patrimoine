class ImageMarcheCartoModel {
  final int id;
  final int marche_id;
  final String fichier;
  final String longitude;
  final String latitude;
  final String libelle;

  ImageMarcheCartoModel({
    required this.id,
    required this.fichier,
    required this.marche_id,
    required this.longitude,
    required this.latitude,
    required this.libelle,
   
  });

  /// Factory pour convertir un JSON en objet Dart
  factory ImageMarcheCartoModel.fromJson(Map<String, dynamic> json) {
    return ImageMarcheCartoModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString().trim() ?? '0') ?? 0,
      marche_id: json['marche_id'] is int
          ? json['marche_id']
          : int.tryParse(json['marche_id']?.toString().trim() ?? '0') ?? 0,
      fichier: json['fichier']?.toString().trim() ?? '',
      longitude: json['longitude_marche']?.toString().trim() ?? '',
      latitude: json['latitude_marche']?.toString().trim() ?? '',
      libelle: json['libelle']?.toString().trim() ?? '',
      
    );
  }

  /// Convertir l'fichier en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fichier': fichier,
      
    };
  }
}
