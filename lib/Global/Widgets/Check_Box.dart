import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

class C_Check_Box extends StatefulWidget {
  final bool isChecked;
  final bool is_enabled;
  final void Function(bool) onChanged;

  const C_Check_Box({
    this.isChecked = true,
    this.is_enabled = true,
    required this.onChanged,
    super.key,
  });

  @override
  State<C_Check_Box> createState() => _C_Check_BoxState();
}

class _C_Check_BoxState extends State<C_Check_Box> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8.w,
      child: Transform.scale(
        scale: 0.10.h,
        child: Checkbox(
          fillColor: !widget.is_enabled
              ? MaterialStateProperty.all<Color>(Get_Grey200)
              : null,
          value: widget.is_enabled ? widget.isChecked : false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.h),
          ),
          activeColor: Get_Black,
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(
              width: 1,
              color: !widget.is_enabled
                  ? Get_Grey300
                  : widget.isChecked
                      ? Get_Black
                      : Get_Black45,
            ),
          ),
          onChanged: widget.is_enabled
              ? (value) => widget.onChanged(value!)
              : (value) {},
        ),
      ),
    );
  }
}
