import 'package:a5bary/models/article_model.dart';
import 'package:dio/dio.dart';

class NewsService {
  final Dio dio;

  NewsService({required this.dio});

  Future<List<ArticleModel>> getGeneralHeadlinesNews({
    String? categoryTitle,
  }) async {
    late Response response;
    if (categoryTitle == null || categoryTitle == "Feeds") {
      response = await dio.get(
        'https://eventregistry.org/api/v1/minuteStreamArticles?apiKey=02bf260e-9411-4546-a3d4-7b92b227205f&lang=eng&isDuplicate=skipDuplicates',
      );
    } else {
      response = await dio.get(
        'https://eventregistry.org/api/v1/minuteStreamArticles?apiKey=02bf260e-9411-4546-a3d4-7b92b227205f&lang=eng&categoryUri=dmoz/$categoryTitle&includeArticleCategories=true,isDuplicate=skipDuplicates',
      );
    }
    Map<String, dynamic> jsonData = response.data;
    List<dynamic> articles =
        jsonData["recentActivityArticles"]["activity"]; //List of Map
    List<ArticleModel> myArticles = []; // List of Object
    for (var article in articles) {
      ArticleModel articleModel = ArticleModel.fromJson(article);
      myArticles.add(articleModel);
    }
    return myArticles;
  }

  Future<List<ArticleModel>> searchNews({required String keyword}) async {
    Response response = await dio.get(
      'https://eventregistry.org/api/v1/article/getArticles?keyword=$keyword&lang=eng&apiKey=02bf260e-9411-4546-a3d4-7b92b227205f&isDuplicate=skipDuplicates',
    );

    Map<String, dynamic> jsonData = response.data;
    List<dynamic> articles = jsonData["articles"]["results"]; //List of Map
    List<ArticleModel> myArticles = []; // List of Object
    for (var article in articles) {
      ArticleModel articleModel = ArticleModel.fromJson(article);
      myArticles.add(articleModel);
    }
    return myArticles;
  }
}
