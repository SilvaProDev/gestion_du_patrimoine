class SeriviceCfModel {
  final int? serviceId;
  final String? libelleService;

  SeriviceCfModel({ 
    this.serviceId,
    this.libelleService
    });


  factory SeriviceCfModel.fromJson(Map<String, dynamic> json){
      return SeriviceCfModel(
         serviceId: json['id'] is int? json['id']
                : int.tryParse(json['id']?.toString() ?? ''),
        libelleService: json['libelle'] ?? "",
        );
  }
  
   Map<String, dynamic> toJson() => {
        "id": serviceId,
        "libelle": libelleService,
      };

}
