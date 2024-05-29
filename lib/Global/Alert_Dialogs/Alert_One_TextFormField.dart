import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/TextFormField.dart';

Future<void> C_Alert_One_TextField({
  String? initial_value,
  double top_margin = 17,
  required String title,
  String? content,
  required String hint_text,
  required String save_button_text,
  required BuildContext context,
  required void Function(String) onSaved,
  required void Function() onSubmit,
  String? Function(String)? validate,
  int max_length = 30,
  bool is_enable_interactive_selection = true,
  RegExp? input_formatter_regex,
  TextInputType keyboard_type = TextInputType.text,
  Widget? prefix_icon,
  Color? focused_prefix_icon_color,
  int min_length = 3,
}) {
  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: top_margin.h),
              child: WillPopScope(
                onWillPop: () => Future.value(false),
                child: AlertDialog(
                  backgroundColor: Get_White,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.h)),
                  titlePadding: EdgeInsets.only(
                      top: 3.h, bottom: 2.h, right: 10.w, left: 10.w),
                  title: C_Text(
                    text: title,
                    weight: '600',
                    font_size: 1.75,
                    text_align: TextAlign.center,
                  ),
                  contentPadding: EdgeInsets.only(
                      top: 0, bottom: 2.h, right: 10.w, left: 10.w),
                  content: content != null
                      ? C_Text(
                          text: content,
                          color: Get_Grey,
                          font_size: 1.55,
                          text_align: TextAlign.center,
                        )
                      : null,
                  actionsPadding: EdgeInsets.zero,
                  actions: <Widget>[
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          C_TextFormField(
                            right_margin: 2,
                            left_margin: 2,
                            bottom_margin: 2,
                            vertical_content_padding: 1,
                            hint_text_size: 1.5,
                            font_size: 1.5,
                            border_radius: 1,
                            error_text_size: 1.3,
                            max_length: max_length,
                            input_formatter_regex: input_formatter_regex,
                            keyboard_type: keyboard_type,
                            is_enable_interactive_selection:
                                is_enable_interactive_selection,
                            prefix_icon: prefix_icon,
                            focused_prefix_icon_color:
                                focused_prefix_icon_color,
                            is_auto_focus: true,
                            hint_text: hint_text,
                            initial_value: initial_value,
                            text_input_action: TextInputAction.done,
                            onSaved: onSaved,
                            validate: (value) {
                              if (value.length < min_length) {
                                return '$hint_text ${'should be more than'} $min_length ${'characters'}';
                              }
                              if (validate != null) {
                                return validate(value);
                              }
                              return null;
                            },
                          ),
                          ColoredBox(
                            color: Get_Grey,
                            child: SizedBox(
                              height: 0.02.h,
                              width: double.infinity,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: ColoredBox(
                                    color: Get_Trans,
                                    child: SizedBox(
                                      height: 5.3.h,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: C_Text(
                                          text: 'Cancel',
                                          color: Get_Grey,
                                          weight: '500',
                                          font_size: 1.75,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ColoredBox(
                                color: Get_Grey,
                                child: SizedBox(width: 0.02.h, height: 5.3.h),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      return onSubmit();
                                    }
                                  },
                                  child: ColoredBox(
                                    color: Get_Trans,
                                    child: SizedBox(
                                      height: 5.3.h,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: C_Text(
                                          weight: '500',
                                          font_size: 1.75,
                                          color: Get_Primary,
                                          text: save_button_text,
                                          text_align: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
