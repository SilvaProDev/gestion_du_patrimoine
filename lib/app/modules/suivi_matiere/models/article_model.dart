class ArticleModel {
  final int? articleId;
  final String? libelleArticle;

  ArticleModel({ 
    this.articleId,
    this.libelleArticle
    });


  factory ArticleModel.fromJson(Map<String, dynamic> json){
      return ArticleModel(
         articleId: json['article_id'] is int? json['article_id']
                : int.tryParse(json['article_id']?.toString() ?? ''),
        libelleArticle: json['libelle'] ?? "",
        );
  }
  
   Map<String, dynamic> toJson() => {
        "article_id": articleId,
        "libelle": libelleArticle,
      };

}
