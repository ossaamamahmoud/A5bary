import 'package:a5bary/models/article_model.dart';
import 'package:a5bary/screens/web_view_screen.dart';
import 'package:a5bary/services/news_service.dart';
import 'package:a5bary/widgets/connectivity_aware_widget.dart';
import 'package:a5bary/widgets/news_card_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShoppingArticlesScreen extends StatefulWidget {
  final String category;
  const ShoppingArticlesScreen({super.key, required this.category});

  @override
  _ShoppingArticlesScreenState createState() => _ShoppingArticlesScreenState();
}

class _ShoppingArticlesScreenState extends State<ShoppingArticlesScreen> {
  Future<List<ArticleModel>>? _allArticlesFuture;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    setState(() {
      _allArticlesFuture = NewsService(dio: Dio()).getGeneralHeadlinesNews();
    });
  }

  Future<void> _onRefresh() async {
    await _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAwareWidget(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(widget.category, style: TextStyle(fontSize: 20.sp)),
        ),
        body: RefreshIndicator(
          color: const Color(0xffF39E3A),
          onRefresh: _onRefresh,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: FutureBuilder<List<ArticleModel>>(
              future: _allArticlesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xffF39E3B),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No articles found for ${widget.category}",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  );
                } else {
                  final articles = snapshot.data!;
                  return ListView.separated(
                    itemBuilder:
                        (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => WebViewScreen(
                                      url: articles[index].url ?? "",
                                    ),
                              ),
                            );
                          },
                          child: NewsCardItem(
                            model: articles[index],
                            categoryTitle: widget.category,
                          ),
                        ),
                    itemCount: articles.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Divider(
                          height: 1.h,
                          color: const Color(0xffE5E5E5),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
