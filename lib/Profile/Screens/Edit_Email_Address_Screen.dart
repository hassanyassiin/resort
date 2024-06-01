import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';

import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/TextFormField.dart';

import '../../../Global/Screens/Loading_Screen.dart';
import '../../Global/Functions/Http_Exception.dart';

import '../../../Profile/Providers/Profile_Model.dart';

class Edit_Email_Address_Screen extends StatefulWidget {
  const Edit_Email_Address_Screen({super.key});
  static const routeName = 'Edit-Email-Address';

  @override
  State<Edit_Email_Address_Screen> createState() =>
      _Edit_Email_Address_ScreenState();
}

class _Edit_Email_Address_ScreenState extends State<Edit_Email_Address_Screen> {
  final _form_key = GlobalKey<FormState>();

  final email_controller = TextEditingController();

  @override
  void initState() {
    email_controller.text = Get_Email;
    super.initState();
  }

  @override
  void dispose() {
    email_controller.dispose();
    super.dispose();
  }

  Future<void> Submit() async {
    if (_form_key.currentState!.validate()) {
      Loading_Screen(context: context);

      final url = Get_REQUEST_URL(url: 'user/Edit-Email');

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $Get_Token'
          },
          body: json.encode({'email': email_controller.text}),
        );

        final response_data = json.decode(response.body);

        if (response.statusCode != 200) {
          throw C_Http_Exception(response_data['ErrorFound'] ?? '');
        }

        final prefs = await SharedPreferences.getInstance();
        String? user_data_string = prefs.getString('userData');

        Map<String, dynamic> userData =
            user_data_string != null ? json.decode(user_data_string) : {};

        userData['Token'] = Get_Token;
        userData['Username'] = Get_Username;
        userData['FirstName'] = Get_First_Name;
        userData['LastName'] = Get_Last_Name;
        userData['Email'] = email_controller.text;
        userData['Region'] = Get_Region;
        userData['PhoneNumber'] = Get_Phone_Number;
        userData['ProfilePic'] = Get_Profile_Pic;

        String updated_user_data_string = json.encode(userData);
        await prefs.setString('userData', updated_user_data_string);

        Set_Email(email_controller.text);

        if (mounted) {
          Provider.of<Profile_Model>(context, listen: false).Notify_Listener();

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
        title: 'Edit Email',
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
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          children: <Widget>[
            C_TextFormField(
              label_text: 'Email',
              top_margin: 2,
              bottom_margin: 2,
              vertical_content_padding: 1.6,
              validate_name_error: 'Email',
              auto_validate_mode: AutovalidateMode.onUserInteraction,
              keyboard_type: TextInputType.emailAddress,
              controller: email_controller,
              validate: (email) {
                if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
                    .hasMatch(email)) {
                  return 'Invalid Email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
