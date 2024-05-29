import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

Widget Pagination_Status({
  required bool has_error,
  bool is_show_error = true,
  required void Function() onTap,
}) {
  if (has_error) {
    return GestureDetector(
      onTap: is_show_error ? onTap : null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.h),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
        width: double.infinity,
        child: C_Text(
          font_size: 1.4,
          color: Get_Grey,
          weight: '500',
          text: is_show_error ? 'Something went wrong!' : '',
        ),
      ),
    );
  }
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Center(
      child: CupertinoActivityIndicator(radius: 1.6.h, color: Get_Black),
    ),
  );
}
