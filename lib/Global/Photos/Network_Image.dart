import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

Widget Hero_Network_Image({
  required String image,
  required dynamic hero,
  required void Function() onTap,
  double border_radius = 0,
  Key? key,
}) {
  return GestureDetector(
    key: key,
    onTap: onTap,
    child: Hero(
      tag: hero,
      child: Container(
        decoration: BoxDecoration(
          color: Get_Shein,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
            onError: (exception, stackTrace) => const SizedBox(),
          ),
          borderRadius: border_radius > 0
              ? BorderRadius.all(Radius.circular(border_radius.h))
              : null,
          border: border_radius > 0 ? Border.all(color: Get_Shein) : null,
        ),
      ),
    ),
  );
}

Widget Rect_Network_Image({
  Key? key,
  required String image,
  double border_radius = 1,
  double aspect_ratio = 3 / 3.5,
  Color? back_ground_color,
}) {
  return AspectRatio(
    key: key,
    aspectRatio: aspect_ratio,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: back_ground_color ?? Get_Shein,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
          onError: (exception, stackTrace) => const SizedBox(),
        ),
        border: border_radius > 0
            ? Border.all(color: back_ground_color ?? Get_Shein, width: 1)
            : null,
        borderRadius: border_radius > 0
            ? BorderRadius.all(Radius.circular(border_radius.h))
            : null,
      ),
    ),
  );
}

Widget Circle_Network_Image({
  Key? key,
  double? width,
  required String image,
  double aspect_ratio = 1 / 1,
  Color? border_color,
  double? border_width,
}) {
  return SizedBox(
    key: key,
    width: width?.w,
    child: AspectRatio(
      aspectRatio: aspect_ratio,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Get_Shein,
          shape: BoxShape.circle,
          border: border_color != null
              ? Border.all(color: border_color, width: border_width ?? 1)
              : null,
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            image: NetworkImage(image),
            onError: (exception, stackTrace) => const SizedBox(),
          ),
        ),
      ),
    ),
  );
}
