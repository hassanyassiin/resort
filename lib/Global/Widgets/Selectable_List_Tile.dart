import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Texts.dart';

Widget Selectable_List_Tile({
  required String title,
  required int key_id,
  required bool is_selected,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      key: ValueKey(key_id),
      alignment: lang == 'Ar' ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
      decoration: BoxDecoration(
        color: is_selected ? Get_Primary : Get_White,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: is_selected ? Get_Primary : Get_Grey200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          C_Text(
            text: title,
            weight: '500',
            font_size: 2,
            color: is_selected ? Get_White : Get_Black,
          ),
          if (is_selected)
            Icon(
              size: 2.2.h,
              color: Get_Grey400,
              Icons.arrow_forward_ios_rounded,
            )
        ],
      ),
    ),
  );
}
