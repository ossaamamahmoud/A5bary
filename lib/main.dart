import 'package:a5bary/screens/news_screen.dart';
import 'package:a5bary/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  // debugPaintSizeEnabled = false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder:
          (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: AppTheme.buildLightTheme(),
            darkTheme: AppTheme.buildDarkTheme(),
            themeMode: ThemeMode.system,
            home: NewsScreen(),
          ),
    );
  }
}
