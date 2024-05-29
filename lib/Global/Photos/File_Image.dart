import 'dart:io';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

Widget Rect_File_Image({
  Key? key,
  String? photo,
  double? left_margin,
  required double width,
  double? right_margin,
  required double aspect_ratio_x,
  required double aspect_ratio_y,
  double border_radius = 1,
}) {
  return Padding(
    key: key,
    padding:
        EdgeInsets.only(right: right_margin?.w ?? 0, left: left_margin?.w ?? 0),
    child: SizedBox(
      width: width.w,
      child: AspectRatio(
        aspectRatio: aspect_ratio_x / aspect_ratio_y,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: photo != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(photo)),
                    onError: (exception, stackTrace) => const SizedBox(),
                  )
                : null,
            border: Border.all(color: Get_Shein, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(border_radius.h)),
          ),
        ),
      ),
    ),
  );
}

Widget Circle_File_Image({
  double? right_margin,
  double? left_margin,
  required String photo,
  required double width,
}) {
  return Padding(
    padding:
        EdgeInsets.only(right: right_margin?.w ?? 0, left: left_margin?.w ?? 0),
    child: SizedBox(
      width: width.w,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get_Shein,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(photo)),
              onError: (exception, stackTrace) => const SizedBox(),
            ),
          ),
        ),
      ),
    ),
  );
}
