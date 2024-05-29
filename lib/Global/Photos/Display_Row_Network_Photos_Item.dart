import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Photos/Network_Image.dart';

List<Widget> Display_Row_Network_Photos_Item({
  required List<String> photos,
  required double photo_width,
  double border_radius = 1,
  double right_margin = 2,
  double left_margin = 2,
  double aspect_ratio = 3 / 3.5,
}) {
  return List.generate(
    photos.length,
    (index) => Padding(
      key: ValueKey(index),
      padding: EdgeInsets.only(left: left_margin.w, right: right_margin.w),
      child: SizedBox(
        width: photo_width.w,
        child: Rect_Network_Image(
          aspect_ratio: aspect_ratio,
          image: photos[index],
          border_radius: border_radius,
        ),
      ),
    ),
  ).toList();
}
