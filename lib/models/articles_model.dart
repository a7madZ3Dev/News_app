class ArticlesList {
  final List<dynamic> articles;
  ArticlesList({required this.articles});

  factory ArticlesList.fromJson(Map<String, dynamic> jsonData) {
    return ArticlesList(articles: jsonData['articles']);
  }
}
