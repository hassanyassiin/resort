import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/Texts.dart';

import '../../../Authentication/Screens/Intro_Screen_Two.dart';

class Intro_Screen_One extends StatelessWidget {
  const Intro_Screen_One({super.key});
  static const routeName = 'Intro-Screen-One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 35.h,
            width: double.infinity,
            child: Image.asset('assets/one.jpeg'),
          ),
          SizedBox(height: 10.h),
          C_Text(
            text_align: TextAlign.center,
            weight: 'Bold',
            text: 'Welcome to Resort',
            font_size: 3.5,
          ),
          SizedBox(height: 3.h),
          C_Text(
            weight: '500',
            font_size: 1.8,
            color: Get_Grey,
            text_align: TextAlign.center,
            text: 'Learn how to recycle effectively with our app.',
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 7.h,
          width: double.infinity,
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              Intro_Screen_Two.routeName,
            ),
            child: Container(
              height: 5.h,
              width: double.infinity,
              margin: EdgeInsets.only(left: 75.w),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Get_Primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                color: Get_White,
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
