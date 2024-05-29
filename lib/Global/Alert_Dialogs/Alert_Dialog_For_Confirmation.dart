import 'package:flutter/material.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Alert_Dialogs/Alert_Dialog.dart';

Future<bool> C_Alert_Dialog_For_Confirmation({
  String? title,
  required String content,
  required BuildContext context,
  required String button_one_title,
  Color? button_one_color,
}) async {
  var delete = false;
  await C_Alert_Dialog(
    context: context,
    title: title ?? 'Are you sure?',
    content: content,
    is_only_one_button: false,
    button_one_title: button_one_title,
    button_one_color: button_one_color ?? Get_Red,
    button_one_function: () {
      // Pop up the Dialog.
      Navigator.pop(context);
      // Pop Up the Targeted Screen.
      delete = true;
    },
    button_two_title: 'Cancel',
  );

  return delete;
}
