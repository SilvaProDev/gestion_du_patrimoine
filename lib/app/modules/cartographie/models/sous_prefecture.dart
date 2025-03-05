class SousPrefectureModel {
  final int? id;
  final String? libelleSousPrefecture;

  SousPrefectureModel({
    this.id,
    this.libelleSousPrefecture,
  });

  factory SousPrefectureModel.fromJson(Map<String, dynamic> json) {
    return SousPrefectureModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      libelleSousPrefecture: json['sous_prefecture'],
     
    );
  }
}
