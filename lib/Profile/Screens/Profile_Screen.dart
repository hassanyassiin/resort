import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../../../../Global/Functions/Colors.dart';
import '../../../../Global/Widgets/AppBar.dart';
import '../../../../Global/Widgets/Texts.dart';
import '../../../Global/Photos/Network_Image.dart';

import '../../../Profile/Providers/Profile_Model.dart';
import '../../../Profile/Screens/Edit_Profile_Pic_Screen.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});
  static const routeName = 'Profile';

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile_Model>(context);

    return Scaffold(
      backgroundColor: Get_Shein,
      appBar: C_AppBar(
        title: 'Profile',
        appBar_color: Get_Shein,
        leading_widget: const SizedBox(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              color: Get_White,
              borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    C_Text(
                      font_size: 2,
                      weight: '600',
                      text: 'Profile Pic',
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Edit_Profile_Pic_Screen.routeName,
                      ),
                      child: C_Text(
                        text: 'Edit',
                        weight: '500',
                        font_size: 2,
                        color: Get_Primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  height: 15.h,
                  width: double.infinity,
                  child: Circle_Network_Image(
                    image: Get_PHOTO_URL(
                      folder: 'profile',
                      image: Get_Profile_Pic,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
