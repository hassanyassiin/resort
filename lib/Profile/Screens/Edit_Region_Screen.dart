import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Authentication/Providers/Authentication.dart';
import '../../../Authentication/Widgets/Signup____Location_Item.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';

import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/Toasts.dart';

import '../../../Global/Screens/Loading_Screen.dart';
import '../../../Global/Functions/Http_Exception.dart';

import '../../../Profile/Providers/Profile_Model.dart';

class Edit_Region_Screen extends StatefulWidget {
  const Edit_Region_Screen({super.key});
  static const routeName = 'Edit-Region';

  @override
  State<Edit_Region_Screen> createState() => _Edit_Region_ScreenState();
}

class _Edit_Region_ScreenState extends State<Edit_Region_Screen> {
  final _form_key = GlobalKey<FormState>();

  var latitude = -100.00;
  var longitude = -100.00;
  var region = 'Beirut';

  @override
  void initState() {
    region = Get_Region;
    super.initState();
  }

  Future<void> Submit() async {
    if (_form_key.currentState!.validate()) {
      _form_key.currentState!.save();

      if (latitude == -100.00) {
        return Show_Text_Toast(
            context: context, text: 'Please press on get location');
      }

      Loading_Screen(context: context);

      final url = Get_REQUEST_URL(url: 'user/Edit-Region');

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $Get_Token'
          },
          body: json.encode({
            'region': region,
            'lat': latitude,
            'lon': longitude,
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
        userData['FirstName'] = Get_First_Name;
        userData['LastName'] = Get_Last_Name;
        userData['Email'] = Get_Email;
        userData['Region'] = region;
        userData['PhoneNumber'] = Get_Phone_Number;
        userData['ProfilePic'] = Get_Profile_Pic;

        String updated_user_data_string = json.encode(userData);
        await prefs.setString('userData', updated_user_data_string);

        Set_Region(region);

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
        title: 'Edit Region',
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
            Signup____Location_Item(
              Get_Region: () => region,
              longitude: longitude,
              latitude: latitude,
              Update_Latitude: (value) => latitude = value,
              Update_Longitude: (value) => longitude = value,
              Update_Region: (value) => region = value,
            ),
          ],
        ),
      ),
    );
  }
}
