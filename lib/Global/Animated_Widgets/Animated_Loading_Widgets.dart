import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/Texts.dart';

Widget Switch_Animated_Loading_Widgets({
  required String loading_widget_name,
  required Animation<Color?> animation,
}) {
  switch (loading_widget_name) {
    case 'Product Item':
      return Product_Item(animation: animation);
    case 'Brasmela':
      return Brasmela_Item(animation: animation);
    default:
      return const SizedBox();
  }
}

Widget Brasmela_Item({required Animation animation}) {
  return C_Text(
    text: '𝐁𝐫𝐚𝐬𝐦𝐞𝐥𝐚',
    font_size: 2.2,
    weight: '500',
    color: animation.value,
    letter_spacing: 2,
  );
  // WAS LIKE THIS.

  // return C_Text(
  //   text: 'BRASMELA',
  //   weight: 'Bold',
  //   font_size: 2,
  //   color: animation.value,
  //   letter_spacing: 3,
  // );
}

Widget Product_Item({required Animation animation}) {
  return UnconstrainedBox(
    child: SizedBox(
      width: 35.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 35.w,
            child: AspectRatio(
              aspectRatio: 3 / 3.5,
              child: Container(
                decoration: BoxDecoration(
                    color: animation.value,
                    borderRadius: BorderRadius.all(Radius.circular(0.5.h))),
              ),
            ),
          ),
          SizedBox(height: 0.45.h),
          Container(
            width: 35.w,
            decoration: BoxDecoration(
                color: animation.value,
                borderRadius: BorderRadius.all(Radius.circular(0.3.h))),
            child: C_Text(text: ' ', font_size: 1.25, max_lines: 1), // Title.
          ),
          SizedBox(height: 1.2.h),
          SizedBox(
            width: 35.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 25.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: animation.value,
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.3.h))),
                        child: C_Text(
                            text: ' ', font_size: 1.385), // Price. 1.5 FOR BIG
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: animation.value,
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.3.h))),
                        child: C_Text(
                            text: ' ',
                            font_size: 1.385), // Selling Unit. 1.5 FOR BIG
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: animation.value,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Get_Trans, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(4.h)),
                  ),
                  child: Icon(
                    size: 1.5.h, // 1.8 FOR BIG
                    color: Get_Trans,
                    Icons.add_shopping_cart_sharp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
