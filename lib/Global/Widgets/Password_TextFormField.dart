import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../Global/Widgets/TextFormField.dart';

class C_Password_TextFormField extends StatefulWidget {
  final void Function(String?)? onSaved;
  final FocusNode? password_focus_node;
  final TextEditingController? controller;
  final double bottom_margin;
  final double top_margin;
  final String title;

  const C_Password_TextFormField({
    this.onSaved,
    this.controller,
    this.password_focus_node,
    this.bottom_margin = 0,
    this.top_margin = 0,
    required this.title,
    super.key,
  });

  @override
  State<C_Password_TextFormField> createState() =>
      _C_Password_TextFormFieldState();
}

class _C_Password_TextFormFieldState extends State<C_Password_TextFormField> {
  var is_tapped = false;

  Widget suffix() {
    return GestureDetector(
      onTap: () {
        setState(() {
          is_tapped = !is_tapped;
        });
      },
      child: Icon(
        is_tapped ? Icons.visibility : Icons.visibility_off,
        size: 3.h,
        color: is_tapped ? Get_Primary : Get_Black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return C_TextFormField(
      label_text: widget.title,
      top_margin: widget.top_margin,
      vertical_content_padding: 1.6,
      bottom_margin: widget.bottom_margin,
      auto_validate_mode: AutovalidateMode.onUserInteraction,
      focus_node: widget.password_focus_node,
      onSaved: widget.onSaved,
      is_obscure: is_tapped ? false : true,
      controller: widget.controller,
      suffix_icon: suffix(),
      text_input_action: TextInputAction.done,
      validate: (password) {
        if (password.length < 8) {
          return '${widget.title} must be at least 8 characters!';
        }
        return null;
      },
    );
  }
}
