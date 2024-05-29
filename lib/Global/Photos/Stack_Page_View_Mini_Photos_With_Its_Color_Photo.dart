import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Photos/Network_Image.dart';
import '../../../Global/Photos/Page_View_Mini_Product_Photos_Item.dart';

Widget Stack_Page_View_Mini_Photos_With_Its_Color_Photo({
  String? color_photo,
  String? color_name,
  required List<String> photos,
}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      Page_View_Mini_Product_Photos_Item(photos: photos, border_radius: 0.9),
      if (color_photo != null)
        Positioned(
          top: 0.5.h,
          right: 1.w,
          child: Container(
            padding: EdgeInsets.all(0.15.h),
            decoration: BoxDecoration(
              color: Get_White,
              shape: BoxShape.circle,
            ),
            child: Circle_Network_Image(width: 3.85, image: color_photo),
          ),
        ),
      if (color_name != 'DEFAULT' && color_name != 'Flavor')
        Container(
          width: 20.w,
          padding: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 0.5.w),
          decoration: BoxDecoration(
              color: Get_Black54,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.9.h),
                  bottomRight: Radius.circular(0.9.h))),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: C_Text(
              text_align: TextAlign.center,
              font_size: 1.45,
              weight: '600',
              text: color_name!,
              color: Get_White,
            ),
          ),
        ),
    ],
  );
}
