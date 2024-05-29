import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

Widget C_TextFormField({
  Key? key,
  BuildContext? context,
  void Function()? onTap,
  void Function(String)? onSaved,
  void Function(String)? onChanged,
  String? Function(String)? validate,
  void Function(String)? onFieldSubmitted,
  TextEditingController? controller,
  Widget? suffix,
  Widget? prefix,
  Widget? prefix_icon,
  Widget? suffix_icon,
  FocusNode? focus_node,
  FocusNode? requested_focus_node,
  String? initial_value,
  String? regex_error_statement,
  Color border_color = Colors.grey,
  Color focused_hint_text_error_color = Colors.grey,
  Color label_text_color = Colors.grey,
  Color focused_hint_text_color = Colors.grey,
  Color hint_text_color = Colors.grey,
  Color? cursor_color,
  Color prefix_icon_color = Colors.grey,
  Color suffix_icon_color = Colors.grey,
  Color suffix_color = Colors.grey,
  Color textFormField_color = Colors.white,
  Color? focused_prefix_icon_color,
  Color? focused_suffix_icon_color,
  Color? focused_suffix_color,
  Color text_color = Colors.black,
  FontWeight text_font_weight = FontWeight.w400,
  String? hint_text,
  String? label_text,
  String? regex,
  String? validate_name_error,
  double? top_margin,
  double? bottom_margin,
  double? right_margin,
  double? left_margin,
  int max_length = 255,
  int min_lines = 1,
  int max_lines = 1,
  double border_radius = 1.5,
  double font_size = 2,
  bool is_for_business_hours = false,
  double hint_text_size = 2,
  double label_text_size = 2,
  double vertical_content_padding = 2,
  double horizontal_content_padding = 3,
  double error_text_size = 1.5,
  double prefix_icon_min_width_constraints = 13,
  RegExp? input_formatter_regex,
  bool is_change_border_on_disabled = true,
  bool is_small = false,
  bool is_optional = false,
  bool is_obscure = false,
  bool is_read_only = false,
  bool is_remove_border = false,
  bool is_auto_focus = false,
  bool is_enabled = true,
  bool is_enable_focused_border = true,
  bool is_show_counter = false,
  bool is_enable_interactive_selection = true,
  TextAlign text_align = TextAlign.start,
  TextInputType keyboard_type = TextInputType.text,
  bool is_ltr = false,
  TextInputAction text_input_action = TextInputAction.next,
  AutovalidateMode auto_validate_mode = AutovalidateMode.disabled,
  TextCapitalization text_capitalization = TextCapitalization.sentences,
  TextDecoration text_decoration = TextDecoration.none,
}) {
  return Container(
    key: key,
    margin: EdgeInsets.only(
      top: top_margin?.h ?? 0,
      bottom: bottom_margin?.h ?? 0,
      right: right_margin?.w ?? 0,
      left: left_margin?.w ?? 0,
    ),
    decoration: BoxDecoration(
        color: textFormField_color,
        borderRadius: BorderRadius.all(Radius.circular(border_radius.h))),
    child: Directionality(
      textDirection: is_ltr
          ? TextDirection.ltr
          : (lang == 'Ar' ? TextDirection.rtl : TextDirection.ltr),
      child: TextFormField(
        maxLines: max_lines,
        minLines: min_lines,
        cursorColor: cursor_color ?? Get_Primary,
        initialValue: initial_value,
        maxLength: max_length,
        enabled: is_enabled,
        obscureText: is_obscure,
        autocorrect: false,
        textInputAction: text_input_action,
        textCapitalization: text_capitalization,
        keyboardType: keyboard_type,
        readOnly: is_read_only,
        focusNode: focus_node,
        autofocus: is_auto_focus,
        autovalidateMode: auto_validate_mode,
        textAlign: text_align,
        controller: controller,
        onTap: onTap,
        inputFormatters: input_formatter_regex != null
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(input_formatter_regex)
              ]
            : null,
        enableInteractiveSelection: is_enable_interactive_selection,
        style: TextStyle(
          height: 1.15,
          fontSize: is_small ? 1.8.h : font_size.h,
          color: text_color,
          fontWeight: text_font_weight,
          decoration: text_decoration,
        ),
        decoration: InputDecoration(
          border: is_remove_border ? InputBorder.none : null,
          counterText: is_show_counter ? null : '',
          alignLabelWithHint: true,
          suffixIcon: suffix_icon,
          suffixIconColor:
              WidgetStateColor.resolveWith((Set<WidgetState> states) {
            Color color = suffix_icon_color;

            if (states.contains(WidgetState.error)) {
              color = Get_Red;
            } else if (states.contains(WidgetState.focused)) {
              color = focused_suffix_icon_color ?? suffix_icon_color;
            }
            return color;
          }),
          suffix: suffix,
          suffixStyle:
              WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
            Color color = suffix_color;
            if (states.contains(WidgetState.error)) {
              color = Get_Red;
            } else if (states.contains(WidgetState.focused)) {
              color = focused_suffix_color ?? Get_Primary;
            }
            return TextStyle(color: color);
          }),
          prefixIcon: prefix_icon,
          prefix: prefix,
          prefixIconConstraints: BoxConstraints(
            minWidth: prefix_icon_min_width_constraints.w,
            maxWidth: (prefix_icon_min_width_constraints + 3).w,
          ),
          prefixIconColor:
              WidgetStateColor.resolveWith((Set<WidgetState> states) {
            Color color = prefix_icon_color;

            if (states.contains(WidgetState.error)) {
              color = Get_Red;
            } else if (states.contains(WidgetState.focused)) {
              color = focused_prefix_icon_color ?? prefix_icon_color;
            }
            return color;
          }),
          isDense: true,
          helperMaxLines: 3,
          helperStyle: TextStyle(fontSize: 1.3.h),
          focusColor: Get_Red,
          contentPadding: EdgeInsets.symmetric(
            vertical: is_small ? 1.3.h : vertical_content_padding.h,
            horizontal: horizontal_content_padding.w,
          ),
          hintText: hint_text,
          hintStyle: WidgetStateTextStyle.resolveWith(
            (Set<WidgetState> states) {
              Color color = hint_text_color;

              if (states.contains(WidgetState.error) &&
                  states.contains(WidgetState.focused)) {
                color = focused_hint_text_error_color;
              } else if (states.contains(WidgetState.error)) {
                color = Get_Red;
              } else if (states.contains(WidgetState.focused)) {
                color = focused_hint_text_color;
              }
              return TextStyle(
                height: 1.15,
                fontWeight: FontWeight.w400,
                fontSize: is_small ? 1.8.h : hint_text_size.h,
                color: color,
              );
            },
          ),
          labelText: label_text,
          labelStyle: WidgetStateTextStyle.resolveWith(
            (Set<WidgetState> states) {
              Color color = label_text_color;

              if (states.contains(WidgetState.error)) {
                color = Get_Red;
              }
              return TextStyle(
                height: 1.15,
                color: color,
                fontSize: is_small ? 1.8.h : label_text_size.h,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              );
            },
          ),
          floatingLabelStyle: WidgetStateTextStyle.resolveWith(
            (Set<WidgetState> states) {
              Color color = label_text_color;

              if (states.contains(WidgetState.error)) {
                color = Get_Red;
              } else if (states.contains(WidgetState.focused)) {
                color = Get_Primary;
              }
              return TextStyle(
                height: 1.15,
                color: is_for_business_hours ? Get_Grey : color,
                fontSize: is_small ? 2.h : 2.h,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              );
            },
          ),
          errorStyle: TextStyle(
            height: 1.15,
            fontSize: error_text_size.h,
            color: Get_Red,
            fontWeight: FontWeight.w400,
          ),
          errorMaxLines: 10,
          enabledBorder: is_remove_border
              ? null
              : outline_input_border(
                  color: border_color.withOpacity(0.25),
                  border_radius: border_radius,
                ),
          focusedBorder: outline_input_border(
            color: is_enable_focused_border
                ? Get_Primary
                : border_color.withOpacity(0.25),
            border_radius: border_radius,
            width: is_enable_focused_border ? 1.5 : 1,
          ),
          errorBorder: outline_input_border(
            color: Get_Red200,
            border_radius: border_radius,
          ),
          focusedErrorBorder: outline_input_border(
            color: Get_Red,
            border_radius: border_radius,
            width: 1.5,
          ),
          disabledBorder: is_remove_border
              ? InputBorder.none
              : is_change_border_on_disabled
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: Get_BlueGrey50),
                    )
                  : outline_input_border(
                      color: Get_Grey25,
                      border_radius: border_radius,
                    ),
        ),
        onFieldSubmitted: (value) {
          if (onFieldSubmitted != null) {
            return onFieldSubmitted(value.trim());
          }

          requested_focus_node != null && context != null
              ? FocusScope.of(context).requestFocus(requested_focus_node)
              : null;
        },
        onChanged: (value) =>
            onChanged != null ? onChanged(value.trim()) : null,
        onSaved: (value) =>
            onSaved != null ? onSaved(value == null ? '' : value.trim()) : null,
        validator: (val) {
          var value = val == null ? '' : val.trim();

          if (is_optional && value.isEmpty) {
            return null;
          }

          if (value.isEmpty) {
            return '${validate_name_error ?? label_text ?? hint_text} can\'t be empty.';
          }

          if (regex != null) {
            if (!RegExp(regex).hasMatch(value)) {
              return regex_error_statement ??
                  'Invalid ${validate_name_error ?? label_text ?? hint_text}.';
            }
          }
          if (validate != null) {
            return validate(value);
          }
          return null;
        },
      ),
    ),
  );
}

OutlineInputBorder outline_input_border({
  required Color color,
  required double border_radius,
  double width = 1,
}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
    borderRadius: BorderRadius.circular(border_radius.h),
  );
}
