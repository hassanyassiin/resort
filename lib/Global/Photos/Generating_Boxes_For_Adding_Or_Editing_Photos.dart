import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Photos/File_Image.dart';

Widget Generating_Boxes_For_Adding_Or_Editing_Photos({
  required String title,
  required void Function() onEdit,
  required void Function() onPick,
  required List<XFile> photos,
  required int max_photos_count,
  required double aspect_ratio_x,
  required double aspect_ratio_y,
  bool is_for_review = false,
  required double width,
}) {
  if (is_for_review && photos.isEmpty) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        color: Get_Trans,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              size: 2.2.h,
              Icons.add_a_photo_outlined,
            ),
            SizedBox(width: 2.5.w),
            C_Rich_Text(
              a_weight: '600',
              a_text: 'Add Photo',
              a_size: 1.6,
              b_text: '  (Optional)',
              b_color: Get_Grey,
              b_weight: '500',
              b_size: 1.5,
            ),
          ],
        ),
      ),
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            C_Rich_Text(
              a_text: '$title  ',
              a_size: 2.1,
              b_text: '${photos.length} / $max_photos_count',
            ),
            GestureDetector(
              onTap: photos.isEmpty ? null : onEdit,
              child: C_Text(
                text: 'Edit',
                font_size: 2.1,
                color: photos.isEmpty ? Get_Grey400 : Get_Primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: photos.length == max_photos_count ? null : onPick,
                child: SizedBox(
                  width: width.w,
                  child: AspectRatio(
                    aspectRatio: aspect_ratio_x / aspect_ratio_y,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(1.h)),
                          border: Border.all(color: Get_Shein, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            size: 2.9.h,
                            color: Get_Primary,
                            photos.length == max_photos_count
                                ? Icons.check_circle_rounded
                                : Icons.add_a_photo_outlined,
                          ),
                          SizedBox(height: 0.5.h),
                          C_Text(
                            font_size: 1.6,
                            color: Get_Primary,
                            weight: '500',
                            text: photos.length == max_photos_count
                                ? 'Completed'
                                : 'Add Photo',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              ...List.generate(
                max_photos_count,
                (index) {
                  return Rect_File_Image(
                    key: ValueKey(index),
                    width: width,
                    left_margin: 2,
                    right_margin: 2,
                    aspect_ratio_x: aspect_ratio_x,
                    aspect_ratio_y: aspect_ratio_y,
                    photo: photos.length > index ? photos[index].path : null,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
