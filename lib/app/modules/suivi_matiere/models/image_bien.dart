class ImageBienModel {
  final String fichier;
  final int articleId;
  final int? stockArticleId;

  ImageBienModel({
    required this.fichier,
    required this.articleId,
     this.stockArticleId,
  });

 factory ImageBienModel.fromJson(Map<String, dynamic> json) {
    return ImageBienModel(
      fichier: json["fichier"] ?? "",
      articleId: json['article_id'] is int
          ? json['article_id']
          : int.tryParse(json['article_id']?.toString() ?? "0") ?? 0, // Valeur par défaut 0
      stockArticleId: json['stockarticle_id'] is int
          ? json['stockarticle_id']
          : int.tryParse(json['stockarticle_id']?.toString() ?? "0") ?? 0, // Valeur par défaut 0
    );
  }
}
