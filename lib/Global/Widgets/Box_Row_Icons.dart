import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

Widget Box_Row_Icons({
  double? top_margin,
  double? bottom_margin,
  required List<Map<String, dynamic>> icons,
}) {
  return Card(
    margin:
        EdgeInsets.only(top: top_margin ?? 1.h, bottom: bottom_margin ?? 1.h),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: icons
            .map(
              (icon) => GestureDetector(
                onTap: icon['onTap'],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.3.w, vertical: 1.5.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(1.5.h)),
                          color: Get_Shein,
                        ),
                        child: Icon(icon['Icon'],
                            color: Get_Black45, size: 3.h),
                      ),
                    ),
                    SizedBox(height: 1.3.h),
                    Flexible(
                      child: C_Text(
                        text: icon['Title'],
                        font_size: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}
