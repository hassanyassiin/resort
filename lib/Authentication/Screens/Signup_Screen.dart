import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';

import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Buttons.dart';
import '../../../Global/Widgets/TextFormField.dart';
import '../../../Global/Widgets/Password_TextFormField.dart';
import '../../../Global/Widgets/Phone_Number_TextFormField.dart';

import '../../../Global/Screens/Loading_Screen.dart';

import '../../../Authentication/Widgets/Signup____Location_Item.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});
  static const routeName = 'Signup';

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final _form_key = GlobalKey<FormState>();

  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirm_password = TextEditingController();

  var latitude = 0.0;
  var longitude = 0.0;
  var region = 'Beirut';

  @override
  void dispose() {
    first_name.dispose();
    last_name.dispose();
    email.dispose();
    username.dispose();
    password.dispose();
    confirm_password.dispose();
    super.dispose();
  }

  Future<void> Create_Account() async {
    Loading_Screen(context: context);
    try {} catch (error) {
      if (mounted) {
        // To Popup Loading Screen.
        Navigator.pop(context);
        return Error_Dialog(error: error.toString(), context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Get_White,
        appBar: C_AppBar(
          title: 'Sign up',
          is_show_divider: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: C_TextFormField(
                        right_margin: 2,
                        vertical_content_padding: 1.6,
                        label_text: 'First Name',
                        is_enable_interactive_selection: false,
                        validate: (first_name) {
                          if (first_name.length < 3) {
                            return 'First Name must be at least 3 characters!';
                          }
                          return null;
                        },
                        onSaved: (first_name) {},
                      ),
                    ),
                    Expanded(
                      child: C_TextFormField(
                        left_margin: 2,
                        vertical_content_padding: 1.6,
                        label_text: 'Last Name',
                        is_enable_interactive_selection: false,
                        validate: (last_name) {
                          if (last_name.length < 3) {
                            return 'Last Name must be at least 3 characters!';
                          }
                          return null;
                        },
                        onSaved: (last_name) {},
                      ),
                    ),
                  ],
                ),
                C_TextFormField(
                  label_text: 'Email',
                  top_margin: 2,
                  bottom_margin: 2,
                  vertical_content_padding: 1.6,
                  validate_name_error: 'Email',
                  keyboard_type: TextInputType.emailAddress,
                  validate: (email) {
                    if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
                        .hasMatch(email)) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  onSaved: (email) {},
                ),
                Phone_Number_TextFormField(
                  is_auto_focus: false,
                  phone_number: '',
                  onSaved: (number) {},
                ),
                Signup____Location_Item(
                  Get_Region: () => region,
                  longitude: longitude,
                  latitude: latitude,
                  Update_Latitude: (value) => latitude = value,
                  Update_Longitude: (value) => longitude = value,
                  Update_Region: (value) => region = value,
                ),
                C_TextFormField(
                  label_text: 'Username',
                  is_enable_interactive_selection: false,
                  vertical_content_padding: 1.6,
                  input_formatter_regex: RegExp(r'^[a-zA-Z][a-zA-Z0-9._]*'),
                  validate: (username) {
                    if (username.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
                    if (RegExp(r'^[0-9._]+').hasMatch(username)) {
                      return 'Username should start with character';
                    }
                    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9._]*$')
                        .hasMatch(username)) {
                      return 'Usernames can only use Roman letters (a-z, A-Z), numbers, underscores and periods.';
                    }

                    if (username.endsWith('.')) {
                      return 'Username can\'t end with period';
                    }

                    if (username.endsWith('_')) {
                      return 'Username can\'t end with underscore';
                    }
                    return null;
                  },
                  onSaved: (username) {},
                ),
                C_Password_TextFormField(
                  top_margin: 2,
                  title: 'Password',
                  onSaved: (password) {},
                ),
                C_Password_TextFormField(
                  top_margin: 2,
                  title: 'Confirm Password',
                  onSaved: (password) {},
                ),
                SizedBox(height: 10.h),
                Container_Button(
                  title: 'Create Account',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
