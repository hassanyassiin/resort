import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../../../../Global/Functions/Colors.dart';
import '../../../../Global/Widgets/AppBar.dart';
import '../../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/Box_List_Tiles.dart';
import '../../../Global/Photos/Network_Image.dart';

import '../../../Profile/Providers/Profile_Model.dart';
import '../../../Profile/Widgets/Box_For_Editing_User_Data.dart';
import '../../../Profile/Screens/Edit_Profile_Pic_Screen.dart';
import '../../../Profile/Screens/Edit_Name_Screen.dart';
import '../../../Profile/Screens/Edit_Email_Address_Screen.dart';
import '../../../Profile/Screens/Edit_Phone_Number_Screen.dart';
import '../../../Profile/Screens/Edit_Region_Screen.dart';
import '../../../Profile/Screens/Change_Password_Screen.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});
  static const routeName = 'Profile';

  @override
  Widget build(BuildContext context) {
    return Consumer<Profile_Model>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Get_Shein,
          appBar: C_AppBar(
            title: 'Profile',
            appBar_color: Get_Shein,
            leading_widget: const SizedBox(),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Get_White,
                  borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        C_Text(
                          font_size: 2,
                          weight: '600',
                          text: 'Profile Pic',
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            Edit_Profile_Pic_Screen.routeName,
                          ),
                          child: C_Text(
                            text: 'Edit',
                            weight: '500',
                            font_size: 2,
                            color: Get_Primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Align(
                      alignment: Alignment.center,
                      child: Circle_Network_Image(
                        width: 30,
                        image: Get_PHOTO_URL(
                          folder: 'profile',
                          image: Get_Profile_Pic,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Box_For_Editing_User_Data(
                credentials: [
                  {
                    'UserCredentialTitle': 'Name',
                    'UserCredentialData': "$Get_First_Name $Get_Last_Name",
                    'onTap': () => Navigator.pushNamed(
                          context,
                          Edit_Name_Screen.routeName,
                        ),
                  },
                  {
                    'UserCredentialTitle': 'Email address',
                    'UserCredentialData': Get_Email,
                    'onTap': () => Navigator.pushNamed(
                          context,
                          Edit_Email_Address_Screen.routeName,
                        ),
                  },
                  {
                    'UserCredentialTitle': 'Phone number',
                    'UserCredentialData': '+$Get_Phone_Number',
                    'onTap': () => Navigator.pushNamed(
                          context,
                          Edit_Phone_Number_Screen.routeName,
                        ),
                  },
                  {
                    'UserCredentialTitle': 'Region',
                    'UserCredentialData': Get_Region,
                    'onTap': () => Navigator.pushNamed(
                          context,
                          Edit_Region_Screen.routeName,
                        ),
                  },
                ],
              ),
              Box_List_Tiles(
                list_tiles: [
                  {
                    'Prefix': Icons.change_circle,
                    'Title': 'Change Password',
                    'TitleColor': Get_Primary,
                    'PrefixColor': Get_Primary,
                    'Suffix': const SizedBox(),
                    'onTap': () => Navigator.pushNamed(
                          context,
                          Change_Password_Screen.routeName,
                        ),
                  },
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
