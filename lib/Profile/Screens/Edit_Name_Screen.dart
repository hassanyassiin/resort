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

class Edit_Name_Screen extends StatefulWidget {
  const Edit_Name_Screen({super.key});
  static const routeName = 'Edit-Name';

  @override
  State<Edit_Name_Screen> createState() => _Edit_Name_ScreenState();
}

class _Edit_Name_ScreenState extends State<Edit_Name_Screen> {
  final _form_key = GlobalKey<FormState>();

  final first_name_controller = TextEditingController();
  final last_name_controller = TextEditingController();

  @override
  void initState() {
    first_name_controller.text = Get_First_Name;
    last_name_controller.text = Get_Last_Name;
    super.initState();
  }

  @override
  void dispose() {
    first_name_controller.dispose();
    last_name_controller.dispose();
    super.dispose();
  }

  Future<void> Submit() async {
    if (_form_key.currentState!.validate()) {
      Loading_Screen(context: context);

      final url = Get_REQUEST_URL(url: 'user/Edit-Name');

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $Get_Token'
          },
          body: json.encode({
            'firstName': first_name_controller.text,
            'lastName': last_name_controller.text,
          }),
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
        userData['FirstName'] = first_name_controller.text;
        userData['LastName'] = last_name_controller.text;
        userData['Email'] = Get_Email;
        userData['Region'] = Get_Region;
        userData['PhoneNumber'] = Get_Phone_Number;
        userData['ProfilePic'] = Get_Profile_Pic;

        String updated_user_data_string = json.encode(userData);
        await prefs.setString('userData', updated_user_data_string);

        Set_First_Name(first_name_controller.text);
        Set_Last_Name(last_name_controller.text);

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
        title: 'Edit Name',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: C_TextFormField(
                    right_margin: 2,
                    label_text: 'First Name',
                    controller: first_name_controller,
                    vertical_content_padding: 1.6,
                    auto_validate_mode: AutovalidateMode.onUserInteraction,
                    validate: (first_name) {
                      if (first_name.length < 3) {
                        return 'First Name must be at least 3 characters!';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: C_TextFormField(
                    left_margin: 2,
                    vertical_content_padding: 1.6,
                    label_text: 'Last Name',
                    auto_validate_mode: AutovalidateMode.onUserInteraction,
                    controller: last_name_controller,
                    is_enable_interactive_selection: false,
                    validate: (last_name) {
                      if (last_name.length < 3) {
                        return 'Last Name must be at least 3 characters!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
