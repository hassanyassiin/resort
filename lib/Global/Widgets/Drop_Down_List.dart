import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

class C_Drop_Down_List extends StatefulWidget {
  final void Function(String) onChanged;
  final String? selected_value;
  final List<String> list_items;
  final String drop_down_list_title;
  final double? top_margin;
  final double? bottom_margin;

  const C_Drop_Down_List({
    required this.onChanged,
    required this.drop_down_list_title,
    required this.list_items,
    this.selected_value,
    this.top_margin,
    this.bottom_margin,
    super.key,
  });

  @override
  State<C_Drop_Down_List> createState() => _C_Drop_Down_ListState();
}

class _C_Drop_Down_ListState extends State<C_Drop_Down_List> {
  String? drop_down_value;

  @override
  void initState() {
    drop_down_value = widget.selected_value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.5.h,
      width: 45.w,
      margin: EdgeInsets.only(
          top: widget.top_margin?.h ?? 0, bottom: widget.bottom_margin?.h ?? 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.h),
          border: Border.all(color: Get_Grey200)),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context)
              .copyWith(highlightColor: Get_Trans, splashColor: Get_Trans),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: drop_down_value,
              isExpanded: true,
              borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
              icon: Icon(Icons.arrow_drop_down, color: Get_Black),
              hint: C_Text(
                color: Get_Grey,
                font_size: 1.5,
                text: widget.drop_down_list_title,
              ),
              style: TextStyle(
                height: 1.15,
                fontSize: 2.h,
                color: Get_Black,
                fontWeight: FontWeight.w400,
              ),
              elevation: 16,
              onChanged: (String? selected_value) {
                if (mounted) {
                  setState(() {
                    drop_down_value = selected_value!;
                  });
                  widget.onChanged(selected_value!);
                }
              },
              items: widget.list_items.map(
                (item_name) {
                  return DropdownMenuItem<String>(
                    value: item_name,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.5.w, vertical: 0.3.h),
                      child: C_Text(
                        font_size: 1.5,
                        text: item_name,
                        color: item_name == 'Enable Discount'
                            ? Get_Black
                            : Get_Red,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
