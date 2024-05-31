import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/Texts.dart';

Widget Check_Time_Alert({
  required void Function() onTap,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
    decoration: BoxDecoration(
        color: Get_White,
        borderRadius: BorderRadius.all(Radius.circular(1.5.h))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 1.h),
        C_Text(
          weight: '600',
          text_align: TextAlign.center,
          font_size: 2.1,
          text: 'Are you ready ?',
        ),
        SizedBox(height: 1.h),
        const Divider(),
        SizedBox(height: 2.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 55.w,
            height: 5.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Get_Primary,
              borderRadius: BorderRadius.all(Radius.circular(1.5.h))
            ),
            child: C_Text(
              weight: 'Bold',
              text: 'Proceed',
              font_size: 2,
              color: Get_White,
            ),
          ),
        ),
      ],
    ),
  );
}
