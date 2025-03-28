import 'package:flutter/material.dart';

class NewsCategoryItem extends StatelessWidget {
  const NewsCategoryItem({
    super.key,
    required this.title,
    required this.isSelected,
  });
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: !isSelected ? Colors.transparent : Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: !isSelected ? Colors.white : Color(0xffF39E3A),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
