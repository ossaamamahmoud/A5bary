import 'package:a5bary/models/article_model.dart';
import 'package:a5bary/screens/web_view_screen.dart';
import 'package:a5bary/services/news_service.dart';
import 'package:a5bary/widgets/connectivity_aware_widget.dart';
import 'package:a5bary/widgets/news_card_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<ArticleModel>>? _searchFuture;

  /// Trigger search using the entered query.
  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    setState(() {
      _searchFuture = NewsService(dio: Dio()).searchNews(keyword: query.trim());
    });
  }

  /// Refreshes the search results.
  Future<void> _refreshSearch() async {
    if (_searchController.text.trim().isNotEmpty) {
      _performSearch(_searchController.text);
      await _searchFuture ?? Future.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAwareWidget(
      child: Scaffold(
        // A sleek app bar with a built-in search field.
        appBar: AppBar(
          backgroundColor: const Color(0xffF39E3A),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
            onPressed: () => Navigator.pop(context),
          ),
          title: TextField(
            controller: _searchController,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onSubmitted: _performSearch,
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search articles...',
              // change mouse cursor color
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
        body: RefreshIndicator(
          color: const Color(0xffF39E3A),
          onRefresh: _refreshSearch,
          child:
              _searchFuture == null
                  ? Center(
                    child: Text(
                      'Find your news here...',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  )
                  : FutureBuilder<List<ArticleModel>>(
                    future: _searchFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: const Color(0xffF39E3A),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'No articles found',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        );
                      } else {
                        final articles = snapshot.data!;
                        return ListView.separated(
                          padding: EdgeInsets.all(16.w),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => WebViewScreen(
                                          url: article.url ?? "",
                                        ),
                                  ),
                                );
                              },
                              child: NewsCardItem(
                                model: article,
                                categoryTitle: 'Feeds',
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
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
    );
  }
}
