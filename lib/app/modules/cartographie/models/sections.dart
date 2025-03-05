class SectionModel {
  final int? id;
  final String? libelleSection;

  SectionModel({
    this.id,
    this.libelleSection,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleSection: json['libelle_section'],
     
    );
  }
}
