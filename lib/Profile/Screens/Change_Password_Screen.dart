import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Http_Exception.dart';
import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/Toasts.dart';
import '../../../Global/Widgets/Password_TextFormField.dart';
import '../../../Global/Screens/Loading_Screen.dart';

class Change_Password_Screen extends StatefulWidget {
  const Change_Password_Screen({super.key});
  static const routeName = 'Change-Password';

  @override
  State<Change_Password_Screen> createState() => _Change_Password_ScreenState();
}

class _Change_Password_ScreenState extends State<Change_Password_Screen> {
  final _form_key = GlobalKey<FormState>();

  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();

  @override
  void dispose() {
    password_controller.dispose();
    confirm_password_controller.dispose();
    super.dispose();
  }

  Future<void> Submit() async {
    if (_form_key.currentState!.validate()) {
      if (password_controller.text.trim() !=
          confirm_password_controller.text.trim()) {
        return Show_Text_Toast(
            context: context, text: 'Passwords doesn\'t match');
      }

      Loading_Screen(context: context);

      final url = Get_REQUEST_URL(url: 'user/Edit-Password');

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $Get_Token'
          },
          body: json.encode({
            'password': password_controller.text,
          }),
        );

        final response_data = json.decode(response.body);

        if (response.statusCode != 200) {
          throw C_Http_Exception(response_data['ErrorFound'] ?? '');
        }

        if (mounted) {
          // To Popup the Loading Screen.
          Navigator.pop(context);
          // To Popup the Screen.
          return Navigator.pop(context);
        }
      } catch (error) {
        if (mounted) {
          // To Popup the Loading Screen.
          Navigator.pop(context);

          return Error_Dialog(error: error.toString(), context: context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Change Password',
        is_show_divider: true,
        suffix_widgets: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GestureDetector(
                onTap: Submit,
                child: C_Text(
                  text: 'Save',
                  weight: '500',
                  font_size: 2,
                  color: Get_Primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _form_key,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          children: <Widget>[
            C_Password_TextFormField(
              top_margin: 2,
              title: 'New Password',
              controller: password_controller,
            ),
            C_Password_TextFormField(
              top_margin: 2,
              title: 'Confirm Password',
              controller: confirm_password_controller,
            ),
          ],
        ),
      ),
    );
  }
}
