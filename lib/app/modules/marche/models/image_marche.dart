class ImageMarcheModel {
  final String longitude;
  final String latitude;
  final String fichier;
  final String observation;
  final int marcheId;

  ImageMarcheModel({
    required this.longitude,
    required this.latitude,
    required this.fichier,
    required this.observation,
    required this.marcheId,
  });

  factory ImageMarcheModel.fromJson(Map<String, dynamic> json) {
    return ImageMarcheModel(
      longitude: json["longitude"] ?? "",
      latitude: json["latitude"] ?? "",
      fichier: json["fichier"] ?? "",
      observation: json["observation"] ?? "",
      marcheId: json['marche_id'] is int
          ? json['marche_id']
          : int.tryParse(json['marche_id']?.toString() ?? "0") ?? 0,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "longitude": longitude,
      "latitude": latitude,
      "fichier": fichier,
      "observation": observation,
      "marche_id": marcheId,
    };
  }
}
