import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Handle_Inputs.dart';

import '../../../Global/Photos/Network_Image.dart';

Widget Page_View_Mini_Product_Photos_Item({
  double width = 20,
  double border_radius = 1,
  required List<String> photos,
  bool is_allow_scrolling = true,
}) {
  return SizedBox(
    width: width.w,
    child: AspectRatio(
      aspectRatio: 3 / 3.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border_radius.h),
        child: PageView.builder(
          physics: photos.length == 1 || !is_allow_scrolling
              ? const NeverScrollableScrollPhysics()
              : const PageScrollPhysics(),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return Rect_Network_Image(
              border_radius: 0,
              aspect_ratio: 3 / 3.5,
              image: photos[index],
              key: ValueKey(photos[index] + Generate_32_Random_Numbers()),
            );
          },
        ),
      ),
    ),
  );
}
