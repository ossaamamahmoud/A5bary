import 'package:a5bary/models/article_model.dart';
import 'package:a5bary/services/news_service.dart';
import 'package:a5bary/widgets/news_carousel_item.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsCarouselSlider extends StatefulWidget {
  const NewsCarouselSlider({super.key, this.categoryTitle});
  final String? categoryTitle;

  @override
  State<NewsCarouselSlider> createState() => _NewsCarouselSliderState();
}

class _NewsCarouselSliderState extends State<NewsCarouselSlider> {
  List<ArticleModel> articles = [];
  bool _isLoading = true;
  String? _errorMessage;

  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0; // Track current index

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  Future<void> getArticles() async {
    try {
      final fetchedArticles = await NewsService(
        dio: Dio(),
      ).getGeneralHeadlinesNews(categoryTitle: widget.categoryTitle);

      if (fetchedArticles.length > 5) {
        fetchedArticles.shuffle();
        articles = fetchedArticles.take(5).toList();
      } else {
        articles = fetchedArticles;
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(color: const Color(0xffF39E3B)),
        ),
      );
    }

    if (_errorMessage != null) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Error: $_errorMessage',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return Column(
      children: [
        CarouselSlider(
          controller: _carouselController,
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            padEnds: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: List.generate(
            articles.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: NewsCarouselItem(
                model: articles[index],
                categoryTitle: widget.categoryTitle ?? "Feeds",
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: articles.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: const Color(0xffF39E3A),
            dotColor: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
