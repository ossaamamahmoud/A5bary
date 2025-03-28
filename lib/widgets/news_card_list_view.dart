import 'package:a5bary/models/article_model.dart';
import 'package:a5bary/widgets/news_card_item.dart';
import 'package:flutter/material.dart';

class NewsCardListView extends StatelessWidget {
  const NewsCardListView({
    super.key,
    required this.articles,
    required this.categoryTitle,
  });
  final List<ArticleModel> articles;
  final String categoryTitle;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder:
          (context, index) => NewsCardItem(
            model: articles[index],
            categoryTitle: categoryTitle,
          ),
      itemCount: articles.length,
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: const Divider(height: 1, color: Color(0xffE5E5E5)),
        );
      },
    );
  }
}
