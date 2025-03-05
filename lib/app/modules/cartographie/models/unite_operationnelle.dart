class UniteOperationnelleModel {
  final int? id;
  final String? libelleUo;

  UniteOperationnelleModel({
    this.id,
    this.libelleUo,
  });

  factory UniteOperationnelleModel.fromJson(Map<String, dynamic> json) {
    return UniteOperationnelleModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleUo: json['libelle_ua'],
     
    );
  }
}
