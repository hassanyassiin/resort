import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Authentication/Screens/Signup_Screen.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/Buttons.dart';

class Intro_Screen_Three extends StatelessWidget {
  const Intro_Screen_Three({super.key});
  static const routeName = 'Intro-Screen-Three';

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
            child: Image.asset('assets/three.jpeg'),
          ),
          SizedBox(height: 10.h),
          C_Text(
            text_align: TextAlign.center,
            weight: 'Bold',
            text: 'Get Stared!',
            font_size: 3.5,
          ),
          SizedBox(height: 3.h),
          C_Text(
            weight: '500',
            font_size: 1.8,
            color: Get_Grey,
            text_align: TextAlign.center,
            text: 'Join the community and start recycling today.',
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 5.h,
          child: Container_Button(
            left_margin: 25,
            right_margin: 25,
            background_color: Get_Primary,
            title: 'Get Started',
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setString(
                  'Attempt', json.encode({'Is_First': false}));

              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Signup_Screen.routeName, (route) => false);
              }
            },
          ),
        ),
      ),
    );
  }
}
