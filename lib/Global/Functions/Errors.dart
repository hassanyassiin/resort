import 'package:flutter/material.dart';

import '../../../Global/Widgets/Toasts.dart';

import '../../../Global/Alert_Dialogs/Alert_Dialog.dart';

const Map<String, String> _title_errors = {
  // Authentications.
  'Forbidden!': 'Forbidden!',
  'Not Authenticated!': 'Not Authenticated!',
  'Authenticating failed!': 'Authenticating failed!',
  'Incorrect Username': 'Incorrect Username',
  'Wrong username/password': 'Wrong Username/Password',
  'Blocked!': 'You are Blocked!',
  // Images.
  'Picking Image': 'Can\'t upload images right now !',
  'Cropping Image': 'Can\'t crop image right now !',
};

const Map<String, String> _content_errors = {
  // Authentications.
  'Forbidden!': 'Permission not allowed!',
  'Not Authenticated!': 'Not Authenticated!, please try to login again',
  'Authenticating failed!': 'Authenticating failed! please try again later',
  'Incorrect Username': 'This Username doesn\'t belong to any account!',
  'Wrong Username/Password':
      'Please check you Username/Password and retry again!',
  'You are Blocked!': 'Please try again later!',
  // Images.
  'Can\'t upload images right now !': 'Please try again later.',
  'Can\'t crop image right now !': 'Please try again later.',
};

const List<String> toasts_error = [
  'Category Title is Taken!',
  "Product Title is Taken!",
];

bool Is_Error_In_Toast({required String title_error}) {
  if (toasts_error.contains(title_error)) {
    return true;
  } else {
    return false;
  }
}

String Get_Title_Error(String error) {
  if (_title_errors.keys.contains(error)) {
    return _title_errors[error]!;
  }
  return 'Something went wrong!';
}

String Get_Content_Error(String error) {
  if (_content_errors.keys.contains(error)) {
    return _content_errors[error]!;
  }
  return 'Please try again later!';
}

Future<void> Error_Dialog({
  required String error,
  required BuildContext context,
}) {
  if (Is_Error_In_Toast(title_error: error)) {
    return Future.delayed(Duration.zero).then(
      (_) {
        return Show_Text_Toast(
          text: error,
          context: context,
        );
      },
    );
  } else {
    final formatted_title = Get_Title_Error(error);
    final formatted_content = Get_Content_Error(formatted_title);

    return C_Alert_Dialog(
      context: context,
      title: formatted_title,
      content: formatted_content,
      button_one_title: 'Try again!',
    );
  }
}
