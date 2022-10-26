class Article {
  final String title;
  final String? description;
  final String articleUrl;
  final String? imageUrl;
  final String? content;
  final DateTime publishedAt;
  Article({
    required this.title,
    this.description,
    required this.articleUrl,
    this.imageUrl,
    this.content,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    return Article(
      title: jsonData['title'],
      description: jsonData['description'],
      articleUrl: jsonData['url'],
      imageUrl: jsonData['urlToImage'],
      content: jsonData['content'],
      publishedAt: DateTime.parse(jsonData['publishedAt']),
    );
  }
}
