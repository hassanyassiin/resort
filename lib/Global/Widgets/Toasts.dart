import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Photos/File_Image.dart';

void Show_Images_Error_Toast({
  required BuildContext context,
  required List<XFile?> files,
  required bool is_validate_type,
}) {
  if (files.isEmpty) {
    return;
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Get_Grey900_90,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(1.5.h))),
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      duration: const Duration(seconds: 7),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: C_Text(
              text: is_validate_type
                  ? files.length >= 2
                      ? 'Invalid Images'
                      : 'Invalid Image'
                  : files.length >= 2
                      ? 'Images are too large!'
                      : 'Image is too large!',
              font_size: 2,
              color: Get_White,
              weight: 'Bold',
            ),
          ),
          SizedBox(height: 0.7.h),
          Flexible(
            child: C_Text(
              text: is_validate_type
                  ? 'Images must be png,jpg,jpeg or gif'
                  : 'Images size must be max $max_image_size MB!',
              font_size: 1.8,
              color: Get_White70,
              weight: '500',
            ),
          ),
          SizedBox(height: 1.2.h),
          SizedBox(
            height: 20.w / (3 / 4), // was 7.h
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: files.length,
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return Rect_File_Image(
                  aspect_ratio_y: 3,
                  aspect_ratio_x: 4,
                  width: 20,
                  photo: files[index]!.path,
                  right_margin: 2,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

void Show_Text_Toast({
  required BuildContext context,
  required String text,
  IconData? icon,
  Color? back_ground_color,
  void Function()? onTap,
  int duration = 3,
  Color? text_color,
  String weight = '400',
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: back_ground_color ?? Get_Grey900_90,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(1.5.h))),
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.5.w),
      duration: Duration(seconds: duration),
      content: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Get_Trans,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                size: 2.5.h,
                icon ?? Icons.error_outline_rounded,
                color: text_color ?? Get_White,
              ),
              SizedBox(width: 4.w),
              Flexible(
                child: C_Text(
                  text: text,
                  weight: weight,
                  font_size: 1.45,
                  color: text_color ?? Get_White,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
