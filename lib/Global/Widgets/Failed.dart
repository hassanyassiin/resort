import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/AppBar.dart';

Widget Failed_Icon_and_Text({
  String error = 'Something went wrong!',
  IconData icon = Icons.error,
  double icon_size = 3,
  double text_size = 1.5,
  Color icon_color = Colors.redAccent,
  Color text_color = Colors.redAccent,
  bool is_allow_refresh = false,
  void Function()? onTap,
}) {
  final title = Get_Title_Error(error);
  final content = Get_Content_Error(title);

  return GestureDetector(
    onTap: is_allow_refresh ? onTap : null,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          size: icon_size.h,
          color: icon_color,
          is_allow_refresh ? Icons.replay : icon,
        ),
        SizedBox(height: 1.h),
        Flexible(
          child: C_Text(
            text: content,
            color: text_color,
            font_size: text_size,
          ),
        ),
      ],
    ),
  );
}

Widget Loading_Scaffold({
  Color scaffold_color = Colors.white,
  Color appBar_color = Colors.white,
  required String appBar_title,
  double? elevation,
  bool is_show_appBar_divider = false,
  bool is_show_appBar_progress_indicator = false,
}) {
  return Scaffold(
    backgroundColor: scaffold_color,
    appBar: C_AppBar(
      title: appBar_title,
      elevation: elevation ?? 0.0,
      is_show_divider: is_show_appBar_divider,
      appBar_color: appBar_color,
      suffix_widgets: [
        if (is_show_appBar_progress_indicator)
          Padding(
            padding: EdgeInsets.only(
              right: lang == 'Ar' ? 0 : 4.w,
              left: lang == 'Ar' ? 4.w : 0,
            ),
            child: CupertinoActivityIndicator(color: Get_Black, radius: 1.h),
          ),
      ],
    ),
    body: Center(
      child: CupertinoActivityIndicator(color: Get_Black, radius: 1.4.h),
    ),
  );
}

Widget Failed_Scaffold({
  Color scaffold_color = Colors.white,
  Color appBar_color = Colors.white,
  required String appBar_title,
  bool is_show_appBar_progress_indicator = false,
  bool is_allow_refresh = false,
  bool is_show_appBar_divider = false,
  double? elevation,
  required String error_message,
  void Function()? onRefresh_tap,
}) {
  final title = Get_Title_Error(error_message);
  final content = Get_Content_Error(title);

  return Scaffold(
    backgroundColor: scaffold_color,
    appBar: C_AppBar(
      title: appBar_title,
      elevation: elevation ?? 0.0,
      appBar_color: appBar_color,
      is_show_divider: is_show_appBar_divider,
      suffix_widgets: [
        if (is_show_appBar_progress_indicator)
          Padding(
            padding: EdgeInsets.only(
              right: lang == 'Ar' ? 0 : 2.w,
              left: lang == 'Ar' ? 2.w : 0,
            ),
            child: GestureDetector(
              onTap: is_allow_refresh ? onRefresh_tap : null,
              child: Icon(
                size: 2.3.h,
                color: is_allow_refresh ? Get_Black : Get_Red,
                is_allow_refresh ? Icons.replay_rounded : Icons.error,
              ),
            ),
          ),
      ],
    ),
    body: Center(
      child: Failed_Icon_and_Text(
        error: content,
        text_color: Get_Black,
        onTap: onRefresh_tap,
        is_allow_refresh: is_allow_refresh,
      ),
    ),
  );
}
