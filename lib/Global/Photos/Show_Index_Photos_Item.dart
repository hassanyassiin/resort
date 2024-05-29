import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/TextFormField.dart';

Widget Show_Index_Photos({
  Color? box_color,
  double bottom_margin = 2,
  required int photos_length,
  bool is_large_text = false,
  required TextEditingController view_photo_index_controller,
}) {
  return UnconstrainedBox(
    child: Container(
      margin: EdgeInsets.only(bottom: bottom_margin.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: box_color ?? Get_Black75,
        borderRadius: BorderRadius.all(Radius.circular(4.h)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: is_large_text ? 2.2.w : 1.8.w,
            child: C_TextFormField(
              key: const ValueKey('Photo Index'),
              textFormField_color: Get_Trans,
              vertical_content_padding: 0.3,
              font_size: is_large_text ? 1.8 : 1.4,
              text_color: Get_White,
              text_font_weight: FontWeight.w500,
              horizontal_content_padding: 0,
              is_optional: true,
              is_enabled: false,
              is_remove_border: true,
              text_align: TextAlign.center,
              controller: view_photo_index_controller,
            ),
          ),
          C_Text(
            text: ' / ',
            font_size: is_large_text ? 1.8 : 1.4,
            color: Get_White,
            weight: '500',
          ),
          SizedBox(
            width: 1.8.w,
            child: C_Text(
              color: Get_White,
              weight: '500',
              text: photos_length.toString(),
              font_size: is_large_text ? 1.8 : 1.4,
            ),
          )
        ],
      ),
    ),
  );
}
