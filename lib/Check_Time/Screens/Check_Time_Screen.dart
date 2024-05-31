import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';

import '../.././Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Failed.dart';
import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Screens/Loading_Screen.dart';

import '../../../Global/Alert_Dialogs/Alert_Dialog_For_Confirmation.dart';

import '../../../Check_Time/Widgets/Check_Time_Alert.dart';
import '../../../Check_Time/Continued_Providers/Change_Status.dart';
import '../../../Check_Time/Continued_Providers/Get_Available_Schedules.dart';

class Check_Time_Screen extends StatefulWidget {
  const Check_Time_Screen({super.key});
  static const routeName = 'Check-Time';

  @override
  State<Check_Time_Screen> createState() => _Check_Time_ScreenState();
}

class _Check_Time_ScreenState extends State<Check_Time_Screen> {
  var is_first_request_success = false;

  var region = '';
  var date = '';

  Future<void> Submit() async {
    var is_confirmed = await C_Alert_Dialog_For_Confirmation(
      context: context,
      button_one_title: 'Proceed',
      button_one_color: Get_Primary,
      content: 'Are you ready to proceed',
    );

    if (!is_confirmed || !mounted) {
      return;
    }

    Loading_Screen(context: context);
    try {
      await Cd_Update_Status(status: 'Proceed');

      if (mounted) {
        // To Popup the Loading Screen.
        Navigator.pop(context);
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
      backgroundColor: Get_Shein,
      appBar: C_AppBar(
        title: 'Check Time',
        appBar_color: Get_Shein,
        is_show_divider: true,
        leading_widget: const SizedBox(),
      ),
      body: FutureBuilder(
        future: !is_first_request_success
            ? Cd_Get_Available_Schedules().then((arguments) {
                if (arguments['Region'] != 'Not Available') {
                  region = arguments['Region'];
                  date = arguments['Date'];
                }
                is_first_request_success = true;
              })
            : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 1.5.h,
                color: Get_Black,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Failed_Icon_and_Text(
                is_allow_refresh: true,
                onTap: () => setState(() {}),
              ),
            );
          } else {
            if (region.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Center(
                  child: C_Text(
                    color: Get_Grey,
                    font_size: 1.5,
                    text: 'There is no schedule yet in your region.',
                  ),
                ),
              );
            } else {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.5.h),
                children: <Widget>[
                  C_Text(
                    weight: '500',
                    font_size: 1.75,
                    text: 'We will be in $region in $date',
                  ),
                  SizedBox(height: 2.5.h),
                  Check_Time_Alert(
                    onTap: Submit,
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
