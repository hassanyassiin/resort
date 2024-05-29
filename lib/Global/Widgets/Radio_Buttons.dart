import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Texts.dart';

class Row_Radio_Buttons_With_Title extends StatefulWidget {
  final String title;
  final String? selected_radio;
  final List<String> radio_buttons;
  final void Function(String) onChanged;
  final bool is_enable_border;
  final double top_padding;
  final double bottom_padding;
  final double left_padding;
  final double right_padding;
  final Color? selected_radio_color;
  final String weight;
  final bool enable_press_on_selected_one;

  const Row_Radio_Buttons_With_Title({
    super.key,
    this.selected_radio,
    required this.title,
    required this.radio_buttons,
    required this.onChanged,
    this.is_enable_border = true,
    this.top_padding = 3,
    this.bottom_padding = 0,
    this.left_padding = 0,
    this.right_padding = 0,
    this.selected_radio_color,
    this.weight = '600',
    this.enable_press_on_selected_one = false,
  });

  @override
  State<Row_Radio_Buttons_With_Title> createState() =>
      _Row_Radio_Buttons_With_TitleState();
}

class _Row_Radio_Buttons_With_TitleState
    extends State<Row_Radio_Buttons_With_Title> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.top_padding.h,
        bottom: widget.bottom_padding.h,
        right: widget.right_padding.w,
        left: widget.left_padding.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          C_Text(
            font_size: 1.80,
            text: widget.title,
            weight: widget.weight,
          ),
          Radio_Buttons(
            horizontal_padding: 0,
            onChanged: widget.onChanged,
            radio_buttons: widget.radio_buttons,
            selected_radio: widget.selected_radio,
            is_enable_border: widget.is_enable_border,
            selected_radio_color: widget.selected_radio_color,
            enable_press_on_selected_one: widget.enable_press_on_selected_one,
          ),
        ],
      ),
    );
  }
}

class Radio_Buttons extends StatefulWidget {
  final String? selected_radio;
  final bool is_enable_border;
  final List<String> radio_buttons;
  final Color? selected_radio_color;
  final void Function(String) onChanged;
  final bool enable_press_on_selected_one;
  final double horizontal_padding;

  const Radio_Buttons({
    super.key,
    this.selected_radio,
    required this.radio_buttons,
    required this.onChanged,
    this.is_enable_border = true,
    this.selected_radio_color,
    this.enable_press_on_selected_one = false,
    this.horizontal_padding = 2,
  });

  @override
  State<Radio_Buttons> createState() => _Radio_ButtonsState();
}

class _Radio_ButtonsState extends State<Radio_Buttons> {
  String? selected_radio;

  @override
  void initState() {
    selected_radio = widget.selected_radio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontal_padding.w),
      child: Wrap(
        children: widget.radio_buttons
            .map(
              (radio_button) => GestureDetector(
                key: ValueKey(radio_button),
                onTap: () {
                  if (selected_radio != radio_button) {
                    setState(() {
                      selected_radio = radio_button;
                    });
                    widget.onChanged(selected_radio!);
                  } else {
                    if (widget.enable_press_on_selected_one) {
                      widget.onChanged(selected_radio!);
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 2.h,
                    right: lang == 'Ar' ? 0 : 4.w,
                    left: lang == 'Ar' ? 4.w : 0,
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 4.w),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: selected_radio == radio_button
                            ? widget.selected_radio_color ?? Get_Primary
                            : widget.is_enable_border
                                ? Get_Grey300
                                : Get_Trans,
                        width: 0.5,
                      ),
                      color: selected_radio == radio_button
                          ? widget.selected_radio_color ?? Get_Primary
                          : Get_White,
                      borderRadius: BorderRadius.all(Radius.circular(2.h))),
                  child: C_Text(
                    font_size: 1.60,
                    text: radio_button,
                    color:
                        selected_radio == radio_button ? Get_White : Get_Black,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class View_Only_Radio_Buttons extends StatefulWidget {
  final List<String> radio_buttons;
  final Color text_color;

  const View_Only_Radio_Buttons({
    super.key,
    required this.radio_buttons,
    this.text_color = Colors.black,
  });

  @override
  State<View_Only_Radio_Buttons> createState() =>
      _View_Only_Radio_ButtonsState();
}

class _View_Only_Radio_ButtonsState extends State<View_Only_Radio_Buttons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: SingleChildScrollView(
        child: Wrap(
          children: widget.radio_buttons
              .map(
                (radio_button) => Container(
                  margin: EdgeInsets.only(
                    top: 2.h,
                    right: lang == 'Ar' ? 0 : 4.w,
                    left: lang == 'Ar' ? 4.w : 0,
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 4.w),
                  decoration: BoxDecoration(
                      color: Get_White,
                      borderRadius: BorderRadius.all(Radius.circular(2.h))),
                  child: C_Text(
                    font_size: 1.60,
                    text: radio_button,
                    color: widget.text_color,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
