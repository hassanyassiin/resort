import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Global/Functions/Colors.dart';

Widget Phone_Number_TextFormField({
  bool is_read_only = false,
  bool is_auto_focus = true,
  required String phone_number,
  void Function(String)? onSaved,
}) {
  List<dynamic> country = Get_Country_From_Phone_Number(phone_number);
  String? filtered_phone_number_without_code;

  if (country.isNotEmpty) {
    filtered_phone_number_without_code =
        Get_Phone_Number_Without_Code(country[0], phone_number);
  }

  return IntlPhoneField(
    initialCountryCode: country.isNotEmpty ? country[0].code : 'LB',
    autovalidateMode: AutovalidateMode.disabled,
    keyboardType: TextInputType.number,
    autofocus: is_auto_focus,
    readOnly: is_read_only,
    cursorColor: Get_Primary,
    textAlign: TextAlign.start,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'^\d+'))
    ],
    style: TextStyle(fontSize: 2.h, height: 1.15, color: Get_Black),
    pickerDialogStyle: PickerDialogStyle(
      listTileDivider: const Divider(thickness: 0.5),
      countryNameStyle: TextStyle(fontSize: 1.6.h),
      searchFieldInputDecoration: InputDecoration(
        contentPadding: EdgeInsets.all(2.h),
        labelText: 'Search Country',
        hintStyle: TextStyle(fontSize: 2.h),
        floatingLabelStyle: TextStyle(color: Get_Primary),
        labelStyle: TextStyle(fontSize: 2.h, color: Get_Grey),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Get_Grey200, width: 1),
            borderRadius: BorderRadius.circular(1.5.h)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Get_Primary, width: 1.5),
            borderRadius: BorderRadius.circular(1.5.h)),
      ),
    ),
    initialValue: filtered_phone_number_without_code ?? '',
    decoration: InputDecoration(
      counterText: '',
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
      labelText: 'Phone Number',
      labelStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        final Color color =
            states.contains(WidgetState.error) ? Get_Red : Get_Grey;
        return TextStyle(fontSize: 2.h, height: 1.15, color: color);
      }),
      floatingLabelStyle:
          WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        final Color color = states.contains(WidgetState.error)
            ? Get_Red
            : states.contains(WidgetState.focused)
                ? Get_Primary
                : !states.contains(WidgetState.selected)
                    ? Get_Grey
                    : Get_Grey;
        return TextStyle(fontSize: 2.2.h, height: 1.15, color: color);
      }),
      errorStyle: TextStyle(color: Get_Red, fontSize: 1.3.h),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Get_Grey200, width: 1),
        borderRadius: BorderRadius.circular(1.5.h),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Get_Primary, width: 1.5),
        borderRadius: BorderRadius.circular(1.5.h),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Get_Red200, width: 1),
        borderRadius: BorderRadius.circular(1.5.h),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Get_Red, width: 1.5),
        borderRadius: BorderRadius.circular(1.5.h),
      ),
    ),
    showCountryFlag: country.length > 1 ? false : true,
    onSaved: (phoneNumber) {
      if (phoneNumber != null && onSaved != null) {
        onSaved((phoneNumber.completeNumber).substring(1));
      }
    },
  );
}

List<dynamic> Get_Country_From_Phone_Number(String phone_number) {
  // it will replace all non-numbers with null, for example : +961 76 789 645  => 96176789645
  String complete_phone_number = phone_number.replaceAll(RegExp('[^0-9]'), '');

  var list_countries = [];

  for (var country in countries) {
    if (complete_phone_number.startsWith(country.dialCode) &&
        (country.maxLength + (country.dialCode).length) ==
            complete_phone_number.length) {
      list_countries.add(country);
    }
  }
  return list_countries;
}

String Get_Phone_Number_Without_Code(Country country, String phone_number) {
  String complete_phone_number = phone_number.replaceAll(RegExp('[^0-9]'), '');
  String filtered_phone_number =
      complete_phone_number.replaceFirst(country.dialCode, '');

  return filtered_phone_number;
}

String Format_Phone_Number(String number) {
  if (number.length != 11) {
    // Ensure the number has the correct length
    return '';
  }

  // Split the number into parts
  String part1 = number.substring(0, 3);
  String part2 = number.substring(3, 5);
  String part3 = number.substring(5, 8);
  String part4 = number.substring(8, 11);

  // Concatenate the parts with the desired format
  String formattedNumber = '$part1-$part2 $part3 $part4';

  return formattedNumber;
}
