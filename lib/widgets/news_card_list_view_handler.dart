import 'package:a5bary/models/article_model.dart';
import 'package:a5bary/services/news_service.dart';
import 'package:a5bary/widgets/news_card_list_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsCardListViewHandler extends StatefulWidget {
  final ValueNotifier<String> selectedCategoryNotifier;
  const NewsCardListViewHandler({
    super.key,
    required this.selectedCategoryNotifier,
  });

  @override
  NewsCardListViewHandlerState createState() => NewsCardListViewHandlerState();
}

class NewsCardListViewHandlerState extends State<NewsCardListViewHandler> {
  Future<List<ArticleModel>>? _newsFuture;

  @override
  void initState() {
    super.initState();
    // Initially load news based on the current category.
    _fetchNewsForCategory(widget.selectedCategoryNotifier.value);
    // Listen for category changes.
    widget.selectedCategoryNotifier.addListener(_onCategoryChanged);
  }

  void _onCategoryChanged() {
    _fetchNewsForCategory(widget.selectedCategoryNotifier.value);
  }

  void _fetchNewsForCategory(String category) {
    setState(() {
      _newsFuture = NewsService(
        dio: Dio(),
      ).getGeneralHeadlinesNews(categoryTitle: category);
    });
  }

  /// This method is called by the RefreshIndicator.
  Future<void> refreshNews() async {
    // Re-fetch news for the current category.
    _fetchNewsForCategory(widget.selectedCategoryNotifier.value);
    // Wait for the fetch to complete.
    await _newsFuture ?? Future.value();
  }

  @override
  void dispose() {
    widget.selectedCategoryNotifier.removeListener(_onCategoryChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(color: const Color(0xffF39E3B)),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                'No news for ${widget.selectedCategoryNotifier.value}',
              ),
            ),
          );
        } else {
          // Build your news list UI here.
          final articles = snapshot.data!;
          return NewsCardListView(
            articles: articles,
            categoryTitle: widget.selectedCategoryNotifier.value,
          );
        }
      },
    );
  }
}
