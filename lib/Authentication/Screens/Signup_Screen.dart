import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';

import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Buttons.dart';
import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/Toasts.dart';
import '../../../Global/Widgets/TextFormField.dart';
import '../../../Global/Widgets/Password_TextFormField.dart';
import '../../../Global/Widgets/Phone_Number_TextFormField.dart';

import '../../../Global/Screens/Loading_Screen.dart';

import '../../../Authentication/Widgets/Signup____Location_Item.dart';
import '../../../Authentication/Screens/Login_Screen.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});
  static const routeName = 'Signup';

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final _form_key = GlobalKey<FormState>();

  final first_name_controller = TextEditingController();
  final last_name_controller = TextEditingController();
  final email_controller = TextEditingController();
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();

  var latitude = -100.00;
  var longitude = -100.00;
  var region = 'Beirut';
  var phone_number = '';

  @override
  void dispose() {
    first_name_controller.dispose();
    last_name_controller.dispose();
    email_controller.dispose();
    username_controller.dispose();
    password_controller.dispose();
    confirm_password_controller.dispose();
    super.dispose();
  }

  Future<void> Create_Account() async {
    if (_form_key.currentState!.validate()) {
      _form_key.currentState!.save();

      if (latitude == -100.00) {
        return Show_Text_Toast(
            context: context, text: 'Please press on get location');
      }

      if (phone_number.length < 5) {
        return Show_Text_Toast(
            context: context, text: 'Please enter valid phone number');
      }

      if (password_controller.text.trim() !=
          confirm_password_controller.text.trim()) {
        return Show_Text_Toast(
            context: context, text: 'Passwords doesn\'t match');
      }

      Loading_Screen(context: context);

      try {
        await Provider.of<Authentication>(context, listen: false).Signup(
          first_name: first_name_controller.text,
          last_name: last_name_controller.text,
          email: email_controller.text,
          phone_number: phone_number,
          latitude: latitude,
          longitude: longitude,
          region: region,
          username: username_controller.text,
          password: password_controller.text,
        );

        if (mounted) {
          // To Popup the Loading Screen.
          Navigator.pop(context);
        }
      } catch (error) {
        if (mounted) {
          // To Popup Loading Screen.
          Navigator.pop(context);
          return Error_Dialog(error: error.toString(), context: context);
        }
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
          leading_widget: const SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Form(
              key: _form_key,
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
                          label_text: 'First Name',
                          controller: first_name_controller,
                          vertical_content_padding: 1.6,
                          auto_validate_mode:
                              AutovalidateMode.onUserInteraction,
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
                          auto_validate_mode:
                              AutovalidateMode.onUserInteraction,
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
                  Phone_Number_TextFormField(
                    is_auto_focus: false,
                    phone_number: '',
                    onSaved: (number) {
                      phone_number = number;
                    },
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
                    controller: username_controller,
                    auto_validate_mode: AutovalidateMode.onUserInteraction,
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
                  ),
                  C_Password_TextFormField(
                    top_margin: 2,
                    title: 'Password',
                    controller: password_controller,
                  ),
                  C_Password_TextFormField(
                    top_margin: 2,
                    title: 'Confirm Password',
                    controller: confirm_password_controller,
                  ),
                  SizedBox(height: 10.h),
                  Container_Button(
                    background_color: Get_Primary,
                    title: 'Create Account',
                    onTap: Create_Account,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: C_Text(
                          max_lines: 1,
                          color: Get_Grey,
                          font_size: 1.5,
                          text: 'Already has an account ? ',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Login_Screen.routeName,
                        ),
                        child: C_Text(
                          max_lines: 1,
                          font_size: 1.5,
                          color: Get_Primary,
                          text: 'Login',
                          text_decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
