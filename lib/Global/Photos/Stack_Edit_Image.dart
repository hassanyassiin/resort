import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Photos/File_Image.dart';
import '../../../Global/Photos/Stack_Edit_And_Close_Item_For_Photo.dart';

Widget Stack_Edit_Image({
  required Key key,
  required XFile image,
  required double width,
  double border_radius = 0,
  required double right_padding,
  required double left_padding,
  required double aspect_ratio_x,
  required double aspect_ratio_y,
  required void Function() onEdit,
  required void Function() onDelete,
}) {
  return Padding(
    padding: EdgeInsets.only(right: right_padding.w, left: left_padding.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Rect_File_Image(
          width: width,
          photo: image.path,
          border_radius: border_radius,
          aspect_ratio_x: aspect_ratio_x,
          aspect_ratio_y: aspect_ratio_y,
        ),
        SizedBox(
          width: width.w,
          child: Stack_Edit_And_Close_Item_For_Photo(
              onEdit: onEdit, onDelete: onDelete),
        ),
      ],
    ),
  );
}
