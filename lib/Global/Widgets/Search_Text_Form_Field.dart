import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/TextFormField.dart';

Widget Search_Text_Form_Field({
  required String hint_text,
  required void Function() onTap,
  double left_margin = 2,
  double right_margin = 2,
}) {
  return GestureDetector(
    onTap: onTap,
    child: C_TextFormField(
      hint_text: hint_text,
      left_margin: left_margin,
      right_margin: right_margin,
      is_remove_border: true,
      bottom_margin: 1,
      font_size: 1.6,
      border_radius: 0.8,
      hint_text_size: 1.7,
      border_color: Get_Shein,
      cursor_color: Get_Black54,
      vertical_content_padding: 1.3,
      is_enabled: false,
      is_enable_focused_border: false,
      textFormField_color: Get_Shein,
      text_input_action: TextInputAction.search,
      prefix_icon_min_width_constraints: 10,
      prefix_icon: Icon(size: 2.4.h, color: Get_Grey, Icons.search_outlined),
    ),
  );
}
