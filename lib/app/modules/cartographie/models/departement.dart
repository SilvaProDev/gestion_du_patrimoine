class DepartementModel {
  final int? id;
  final String? libelleDepartement;

  DepartementModel({
    this.id,
    this.libelleDepartement,
  });

  factory DepartementModel.fromJson(Map<String, dynamic> json) {
    return DepartementModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleDepartement: json['libelle_departement'],
     
    );
  }
}
