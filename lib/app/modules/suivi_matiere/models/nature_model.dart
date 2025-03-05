class NatureEconomiqueModel {
  final int? ligneId;
  final String? libelleLigne;

  NatureEconomiqueModel({required this.ligneId, this.libelleLigne});


  factory NatureEconomiqueModel.fromJson(Map<String, dynamic> json){
      return NatureEconomiqueModel(
         ligneId: json['nature_id'] is int? json['nature_id']
                : int.tryParse(json['nature_id']?.toString() ?? ''),
        libelleLigne: json['code_libelle_ligne'] ?? "",
        //  ligneId: json['ligneId'],
        );
  }
  Map<String, dynamic> toJson() => {
        "nature_id": ligneId,
        "code_libelle_ligne": libelleLigne,
      };
}
