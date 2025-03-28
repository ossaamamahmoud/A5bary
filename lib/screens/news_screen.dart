import 'package:a5bary/screens/shopping_screen.dart';
import 'package:a5bary/widgets/connectivity_aware_widget.dart';
import 'package:a5bary/widgets/custom_app_bar.dart';
import 'package:a5bary/widgets/news_card_list_view_handler.dart';
import 'package:a5bary/widgets/news_carousel_slider.dart';
import 'package:a5bary/widgets/news_category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});

  // Shared notifier for the selected category.
  final ValueNotifier<String> selectedCategoryNotifier = ValueNotifier<String>(
    "Feeds",
  );

  // GlobalKey to access the state of NewsCardListViewHandler.
  final GlobalKey<NewsCardListViewHandlerState> _newsListKey =
      GlobalKey<NewsCardListViewHandlerState>();

  @override
  Widget build(BuildContext context) {
    return ConnectivityAwareWidget(
      child: Scaffold(
        body: SafeArea(
          child: LiquidPullToRefresh(
            // In this app we made hard coded colors
            // which is a bad practice
            // but we will fix this in next apps
            key: UniqueKey(),
            showChildOpacityTransition: false,
            animSpeedFactor: 2,

            springAnimationDurationInMilliseconds: 200,
            color: const Color(0xffF39E3A),

            onRefresh: () async {
              await _newsListKey.currentState?.refreshNews();
            },
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12.h,
                      children: [
                        CustomAppBar(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Breaking News",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.zero,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ShoppingArticlesScreen(
                                          category: "Breaking News",
                                        ),
                                  ),
                                );
                              },
                              child: Text(
                                "See More",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        NewsCarouselSlider(categoryTitle: "Shopping"),
                        NewsCategoryList(
                          selectedCategoryNotifier: selectedCategoryNotifier,
                        ),
                        SizedBox.shrink(),
                      ],
                    ),
                  ),
                  // News list view handler that reloads based on selected category.
                  NewsCardListViewHandler(
                    key: _newsListKey,
                    selectedCategoryNotifier: selectedCategoryNotifier,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
