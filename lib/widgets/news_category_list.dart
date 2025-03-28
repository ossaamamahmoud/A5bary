import 'package:a5bary/widgets/news_category_item.dart';
import 'package:flutter/material.dart';

class NewsCategoryList extends StatefulWidget {
  final ValueNotifier<String> selectedCategoryNotifier;
  const NewsCategoryList({super.key, required this.selectedCategoryNotifier});

  @override
  State<NewsCategoryList> createState() => _NewsCategoryListState();
}

class _NewsCategoryListState extends State<NewsCategoryList> {
  final List<String> categories = [
    "Feeds",
    "Health",
    "Sports",
    "Arts",
    "Business",
  ];
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void scrollToSelected() {
    double itemWidth = 110.0; // Approximate width of an item
    _scrollController.animateTo(
      _selectedIndex * itemWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      width: MediaQuery.of(context).size.width,
      height: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffF39E3A),
      ),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              // Scroll to the tapped category.
              scrollToSelected();
              // Update the shared notifier.
              widget.selectedCategoryNotifier.value = categories[index];
            },
            child: NewsCategoryItem(
              title: categories[index],
              isSelected: _selectedIndex == index,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
