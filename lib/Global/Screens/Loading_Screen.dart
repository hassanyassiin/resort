import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

dynamic Loading_Screen({
  Color? barrier_color,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierColor: barrier_color ?? Get_Loading,
    barrierDismissible: false,
    builder: (ctx) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          elevation: 0,
          backgroundColor: Get_Trans,
          alignment: Alignment.center,
          children: <Widget>[
            UnconstrainedBox(
              child: CupertinoActivityIndicator(color: Get_Black, radius: 2.h),
            ),
          ],
        ),
      );
    },
  );
}
