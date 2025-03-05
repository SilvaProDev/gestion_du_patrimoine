class UniteOperationnelleModel {
  final int? ua_id;
  final String? libelle_ua;

  UniteOperationnelleModel({required this.ua_id, this.libelle_ua});


  factory UniteOperationnelleModel.fromJson(Map<String, dynamic> json){
      return UniteOperationnelleModel(
         ua_id: json['ua_id'] is int? json['ua_id']
                : int.tryParse(json['ua_id']?.toString() ?? ''),
        libelle_ua: json['libelle_ua'] ?? "",
        //  ua_id: json['ua_id'],
        );
  }
   Map<String, dynamic> toJson() => {
        "ua_id": ua_id,
        "libelle_ua": libelle_ua,
      };
}
