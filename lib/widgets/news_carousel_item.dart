import 'package:a5bary/models/article_model.dart';
import 'package:a5bary/screens/web_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsCarouselItem extends StatelessWidget {
  const NewsCarouselItem({
    super.key,
    required this.model,
    required this.categoryTitle,
  });
  final ArticleModel model;
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: model.url ?? ""),
          ),
        );
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                model.image ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbjhM8JsWyHxU9x-2fqi_Z7I1Ovrv0v8IvCvOsp8Bsby5sc8vugWAXUOPhG7wckVx91gk&usqp=CAU",
            imageBuilder:
                (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder:
                (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: const Color(0xffF39E3B),
                  ),
                ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
            bottom: 16.h,
            right: 64.w,
            left: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.source?.title ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  model.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
