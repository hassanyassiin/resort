import 'package:flutter/material.dart';

import '../../../Global/Alert_Dialogs/Alert_Dialog.dart';

Future<bool> C_Alert_Dialog_For_Discarding_Changes(BuildContext context) async {
  var leave = false;
  await C_Alert_Dialog(
    context: context,
    title: 'Discard Changes?',
    content: 'If you go back now, you will lose your changes.',
    is_only_one_button: false,
    button_one_title: 'Discard Changes',
    button_one_function: () {
      // Pop up the Dialog.
      Navigator.pop(context);
      // Pop Up the Targeted Screen.
      leave = true;
    },
    button_two_title: 'Keep Editing',
  );

  return leave;
}
