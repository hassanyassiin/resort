import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Photos/Display_Row_Network_Photos_Item.dart';

Widget View_Product_Network_Photos_Item({
  String? title,
  String? note,
  required List<String> photos,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 1.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        C_Text(
          text: title ?? 'Photos',
          weight: '500',
          font_size: 2.1,
        ),
        SizedBox(height: 2.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: Display_Row_Network_Photos_Item(
              photos: photos,
              photo_width: 27,
            ),
          ),
        ),
        if (note != null)
          Padding(
            padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
            child: C_Text(
              font_size: 1.5,
              max_lines: 3,
              color: Get_Grey,
              text: note,
            ),
          ),
      ],
    ),
  );
}
