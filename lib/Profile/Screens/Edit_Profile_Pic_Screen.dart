import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Http_Exception.dart';
import '../../../Global/Functions/Handle_Images.dart';

import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Screens/Loading_Screen.dart';

import '../../../Global/Photos/Circle_Stack_Choose_And_Edit_Photo.dart';

class Edit_Profile_Pic_Screen extends StatefulWidget {
  const Edit_Profile_Pic_Screen({super.key});
  static const routeName = 'Edit-Profile-Pic-Screen';

  @override
  State<Edit_Profile_Pic_Screen> createState() =>
      _Edit_Profile_Pic_ScreenState();
}

class _Edit_Profile_Pic_ScreenState extends State<Edit_Profile_Pic_Screen> {
  XFile? photo;

  Future<void> Change_Profile_Pic() async {
    if (photo == null) {
      return Navigator.pop(context);
    }

    final url =
        Get_REQUEST_URL(is_form_data: true, url: '/user/Edit-Profile-Pic');

    Loading_Screen(context: context);

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Content-Type'] = "multipart/form-data; charset=UTF-8"
        ..headers['Authorization'] = 'Bearer $Get_Token';

      if (photo != null) {
        request.files.add(
          await http.MultipartFile.fromPath('photo', photo!.path,
              contentType:
                  MediaType('Image', Get_Image_Type(File(photo!.path)))),
        );
      }

      var stream_response = await request.send();
      var response = await http.Response.fromStream(stream_response);

      final response_data = json.decode(response.body) as Map<String, dynamic>;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Edit Profile Pic',
        is_show_divider: true,
        suffix_widgets: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GestureDetector(
                onTap: Change_Profile_Pic,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        child: Circle_Stack_Choose_And_Edit_Photo(
          width: 40,
          file_photo: photo,
          network_image: Get_Profile_Pic,
          onChoose_photo: (new_photo) => photo = new_photo,
        ),
      ),
    );
  }
}
