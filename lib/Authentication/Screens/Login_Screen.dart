import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Authentication/Providers/Authentication.dart';

import '../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Buttons.dart';
import '../../../Global/Widgets/TextFormField.dart';
import '../../../Global/Screens/Loading_Screen.dart';
import '../../../Global/Widgets/Password_TextFormField.dart';

import '../../../Global/Alert_Dialogs/Alert_Dialog.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});
  static const routeName = '/Login';

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  static final _form_key = GlobalKey<FormState>();

  final password_focus_node = FocusNode();

  var credentials = {'account': '', 'password': ''};

  @override
  void dispose() {
    password_focus_node.dispose();
    super.dispose();
  }

  Future<void> Submit(Authentication auth) async {
    if (_form_key.currentState!.validate()) {
      _form_key.currentState!.save();

      Loading_Screen(context: context);
      try {
        await auth.Login(credentials: credentials);

        if (mounted) {
          // To pop up the Loading screen
          return Navigator.pop(context);
        }
      } catch (error) {
        if (mounted) {
          // To pop up the Loading screen
          Navigator.pop(context);

          final title = Get_Title_Error(error.toString());
          final content = Get_Content_Error(title);

          return C_Alert_Dialog(
            context: context,
            title: title,
            content: content,
            button_one_title: 'Try again!',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context, listen: false);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Get_White,
        appBar: C_AppBar(
            // suffix_widgets: [const Language_Icon()],
            ),
        body: Form(
          key: _form_key,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
            children: <Widget>[
              C_Text(
                font_size: 2.5,
                weight: 'Bold',
                color: Get_Black,
                text: '${'Hello'},',
              ),
              SizedBox(height: 0.5.h),
              C_Text(
                font_size: 2.5,
                weight: 'Bold',
                color: Get_Black,
                text: 'Welcome Back',
              ),
              C_TextFormField(
                top_margin: 8,
                bottom_margin: 1.5,
                context: context,
                label_text: 'Username',
                validate_name_error: 'Username',
                requested_focus_node: password_focus_node,
                onSaved: (account) => credentials['account'] = account,
                validate: (account) {
                  if (account.length < 3) {
                    return 'Username must be at least 3 characters!';
                  }
                  return null;
                },
              ),
              C_Password_TextFormField(
                bottom_margin: 1,
                password_focus_node: password_focus_node,
                onSaved: (password) => credentials['password'] = password!,
              ),
              SizedBox(height: 5.h),
              Container_Button(
                title: 'Login',
                border_radius: 1,
                background_color: Get_Primary,
                onTap: () => Submit(auth),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
