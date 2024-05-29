import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

Widget Circle_File_And_Network_Image_Item({
  XFile? file_image,
  double aspect_ratio = 1 / 1,
  String? network_image,
  required double width,
}) {
  return SizedBox(
    width: width.w,
    child: AspectRatio(
      aspectRatio: aspect_ratio,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Get_Shein,
          border: Border.all(color: Get_Shein, width: 1),
          shape: BoxShape.circle,
          image: file_image != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(file_image.path)),
                  onError: (exception, stackTrace) => const SizedBox(),
                )
              : network_image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(network_image),
                      onError: (object, stackTrace) => const SizedBox(),
                    )
                  : null,
        ),
        child: file_image == null && network_image == null
            ? Center(
                child: Icon(size: 3.h, Icons.image, color: Get_White),
              )
            : null,
      ),
    ),
  );
}

Widget Rect_File_And_Network_Image({
  XFile? file_image,
  double aspect_ratio = 1 / 1,
  double border_radius = 1.5,
  String? network_image,
}) {
  return AspectRatio(
    aspectRatio: aspect_ratio,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Get_Shein,
        border: Border.all(color: Get_Shein, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(border_radius.h)),
        image: file_image != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(file_image.path)),
                onError: (exception, stackTrace) => const SizedBox(),
              )
            : network_image != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(network_image),
                    onError: (object, stackTrace) => const SizedBox(),
                  )
                : null,
      ),
    ),
  );
}
