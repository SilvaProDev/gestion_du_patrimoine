class MarcheCartographieModel {
  final int id;
  final String libelleMarche;

  MarcheCartographieModel({
    required this.id,
    required this.libelleMarche,
   
  });

  /// Factory pour convertir un JSON en objet Dart
  factory MarcheCartographieModel.fromJson(Map<String, dynamic> json) {
    return MarcheCartographieModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString().trim() ?? '0') ?? 0,
      libelleMarche: json['objet']?.toString().trim() ?? 'Inconnu',
      
    );
  }

  /// Convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'objet': libelleMarche,
      
    };
  }
}
