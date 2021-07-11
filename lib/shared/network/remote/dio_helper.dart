import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../models/article_model.dart';
import '../../../models/articles_model.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<List<Article>> getDataFromApi(
      {@required String url, @required Map<String, dynamic> query}) async {
    Response response = await dio.get(url, queryParameters: query);
    if (response.statusCode == 200) {
      var jsonData = response.data;
      ArticlesList articlesList = ArticlesList.fromJson(jsonData);
      return articlesList.articles
          .map((element) => Article.fromJson(element))
          .toList();
    } else {
      print('Status Code Is : ${response.statusCode}');
    }
  }
}
