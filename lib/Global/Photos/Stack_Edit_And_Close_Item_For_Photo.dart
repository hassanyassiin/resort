import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

Widget Stack_Edit_And_Close_Item_For_Photo({
  required void Function() onEdit,
  required void Function() onDelete,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        GestureDetector(
          onTap: onEdit,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 1.9.w),
            decoration: BoxDecoration(
              color: Get_Black87,
              borderRadius: BorderRadius.all(Radius.circular(0.6.h)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  size: 1.9.h,
                  Icons.edit_rounded,
                  color: Get_White,
                ),
                SizedBox(width: 1.2.w),
                C_Text(
                  text: 'Edit',
                  color: Get_White,
                  font_size: 1.9,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onDelete,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0.3.h, horizontal: 0.8.w),
            decoration: BoxDecoration(
              color: Get_Black87,
              borderRadius: BorderRadius.all(Radius.circular(0.6.h)),
            ),
            child: Icon(
              size: 2.2.h,
              Icons.close_rounded,
              color: Get_White,
            ),
          ),
        ),
      ],
    ),
  );
}
