import 'package:flutter/material.dart';

Widget BuiltInStepperIndicator(int currentIndex) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(5, (index) {
    return Container(
      width: currentIndex == index ? 12 : 8, // Larger size for active step
      height: currentIndex == index ? 10 : 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            currentIndex == index
                ? Colors.blue
                : Colors.grey, // Highlight active step
      ),
    );
  }),
);
