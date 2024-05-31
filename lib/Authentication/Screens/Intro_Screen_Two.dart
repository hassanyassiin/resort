import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/Texts.dart';

import '../../../Authentication/Screens/Intro_Screen_Three.dart';

class Intro_Screen_Two extends StatelessWidget {
  const Intro_Screen_Two({super.key});
  static const routeName = 'Intro-Screen-Two';

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
            child: Image.asset('assets/two.jpeg'),
          ),
          SizedBox(height: 10.h),
          C_Text(
            text_align: TextAlign.center,
            weight: 'Bold',
            text: 'Sort Your Waste',
            font_size: 3.5,
          ),
          SizedBox(height: 3.h),
          C_Text(
            weight: '500',
            font_size: 1.8,
            color: Get_Grey,
            text_align: TextAlign.center,
            text: 'Easily sort your waste with step-by-step guides.',
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 5.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 20.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Get_Primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    color: Get_White,
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  Intro_Screen_Three.routeName,
                ),
                child: Container(
                  width: 20.w,
                  // margin: EdgeInsets.only(left: 75.w),
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
            ],
          ),
        ),
      ),
    );
  }
}
