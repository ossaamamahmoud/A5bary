import 'package:a5bary/screens/search_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://img.freepik.com/free-vector/smiling-young-man-hoodie_1308-176157.jpg?t=st=1741133740~exp=1741137340~hmac=ae20449e3d797bb741742ed6763fdb3f9f3b288a6a0d98a8ce898398a68f10e4&w=826",
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            Text(
              "Our beloved User",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xffF39E3A),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search, size: 28, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
