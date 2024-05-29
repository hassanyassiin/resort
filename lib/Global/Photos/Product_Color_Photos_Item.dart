import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Infos.dart';
import '../../../Global/Functions/Colors.dart';

import '../../../Global/Photos/Network_Image.dart';

import '../../../Global/Widgets/Texts.dart';

Widget Product_Color_Photos_Item({
  bool is_small = false,
  required List<String> photos,
}) {
  return Container(
    margin: EdgeInsets.only(
      right: lang == 'Ar' ? 0 : 1.w,
      left: lang == 'Ar' ? 1.w : 0,
      bottom: is_small ? 1.h : 1.5.h,
    ),
    width: is_small ? 3.2.w : 3.8.w,
    padding: EdgeInsets.symmetric(vertical: 0.15.h, horizontal: 0.2.w),
    decoration: BoxDecoration(
        color: Get_Black45,
        borderRadius: BorderRadius.all(Radius.circular(1.h))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Circle_Network_Image(
          image: photos[0],
          border_color: Colors.white,
          border_width: 0,
        ),
        if (photos.length > 1) SizedBox(height: 0.5.h),
        if (photos.length > 1)
          Circle_Network_Image(
            image: photos[1],
            border_color: Colors.white,
            border_width: 0,
          ),
        if (photos.length > 2) SizedBox(height: 0.5.h),
        if (photos.length > 2)
          Circle_Network_Image(
            image: photos[2],
            border_color: Colors.white,
            border_width: 0,
          ),
        if (photos.length > 3) SizedBox(height: 0.5.h),
        if (photos.length > 3)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: C_Text(
              font_size: 1,
              weight: '600',
              color: Get_White,
              text: photos.length.toString(),
            ),
          ),
      ],
    ),
  );
}
