import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

Future<void> Version_Alert_Dialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          backgroundColor: Get_White,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
          alignment: Alignment.center,
          titlePadding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
          title: C_Text(
            font_size: 2,
            weight: 'Bold',
            color: Get_Black,
            text_align: TextAlign.center,
            text: 'New Version Available',
          ),
          content: C_Text(
            font_size: 1.8,
            weight: '500',
            color: Get_Grey,
            text_align: TextAlign.center,
            text: 'update the app in the stores, to get the best experience.',
          ),
          contentPadding: EdgeInsets.only(bottom: 2.5.h, right: 2.w, left: 2.w),
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    },
  );
}
