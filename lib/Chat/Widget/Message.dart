import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/Texts.dart';

import '../../../Chat/Providers/Chat_Model.dart';

Widget Message({required Chat_Model chat}) {
  return Align(
    alignment: !chat.is_admin ?  Alignment.centerRight : Alignment.centerLeft,
    child: UnconstrainedBox(
      child: Container(
        constraints: BoxConstraints(minWidth: 1.w,maxWidth: 70.w),
        margin: EdgeInsets.only(bottom: 1.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.4.h),
        decoration: BoxDecoration(
            color:  !chat.is_admin ?   Get_Shein : Get_Primary.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(55.h))),
        child: C_Text(
          weight: '500',
          color: !chat.is_admin ?  Get_Black : Get_White,
          text: chat.text,
          font_size: 1.5,
        ),
      ),
    ),
  );
}
