import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Infos.dart';

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
  var status = 'Not Yet';

  Future<void> Submit({String received_status = 'Proceed'}) async {
    var is_confirmed = await C_Alert_Dialog_For_Confirmation(
      context: context,
      button_one_title: received_status,
      button_one_color: Get_Primary,
      content: 'Are you ready to proceed',
    );

    if (!is_confirmed || !mounted) {
      return;
    }

    Loading_Screen(context: context);
    try {
      await Cd_Update_Status(status: received_status);

      if (mounted) {
        // To Popup the Loading Screen.
        Navigator.pop(context);

        setState(() {
          status = received_status;
        });
      }
    } catch (error) {
      if (mounted) {
        // To Popup the Loading Screen.
        Navigator.pop(context);
        return Error_Dialog(error: error.toString(), context: context);
      }
    }
  }

  bool Is_Same_Date() {
    if (date.trim().isNotEmpty) {
      var day = date.split(' ')[0];
      var month = date.split(' ')[1];
      var year = date.split(' ')[2];

      DateTime schedule_date = DateTime.parse("$year-${dates[month]}-$day");
      DateTime current_date = DateTime.now();

      return schedule_date.year == current_date.year &&
          schedule_date.month == current_date.month &&
          schedule_date.day == current_date.day;
    }
    return false;
  }

  bool Is_Passed() {
    if (date.trim().isNotEmpty) {
      var day = date.split(' ')[0];
      var month = date.split(' ')[1];
      var year = date.split(' ')[2];

      DateTime schedule_date = DateTime.parse("$year-${dates[month]}-$day");
      DateTime current_date = DateTime.now();

      var a = schedule_date.year == current_date.year &&
          schedule_date.month == current_date.month &&
          schedule_date.day == current_date.day;

      return schedule_date.difference(current_date).isNegative;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Check Time',
        appBar_color: Get_White,
        is_show_divider: true,
        leading_widget: const SizedBox(),
      ),
      body: FutureBuilder(
        future: !is_first_request_success
            ? Cd_Get_Available_Schedules().then((arguments) {
                if (arguments['Region'] != 'Not Available') {
                  region = arguments['Region'];
                  date = arguments['Date'];
                  status = arguments['Status'];
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.5.h),
                child: Column(
                  mainAxisAlignment: status == 'Proceed' && Is_Same_Date()
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  crossAxisAlignment: status == 'Proceed' && Is_Same_Date()
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    if (status == 'Not Yet')
                      C_Text(
                        weight: '500',
                        font_size: 1.75,
                        text: 'We will be in $region in $date',
                      ),
                    if (status == 'Not Yet') SizedBox(height: 2.5.h),
                    if (status == 'Not Yet') Check_Time_Alert(onTap: Submit),
                    if (status == 'Proceed' && Is_Same_Date())
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Image.asset('assets/four.jpeg'),
                          SizedBox(height: 5.h),
                          C_Text(
                            text_align: TextAlign.center,
                            weight: 'Bold',
                            text: 'We are coming to you today.',
                            font_size: 1.8,
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () =>
                                    Submit(received_status: 'Delivered'),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: Get_Primary,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(1.2.h)),
                                  ),
                                  child: C_Text(
                                    weight: '500',
                                    font_size: 1.8,
                                    color: Get_White,
                                    text: 'Did you Delivered ?',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (status == 'Proceed' && !Is_Same_Date())
                      if (Is_Passed())
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: 30.h,
                              child: Image.asset('assets/twelve.jpeg'),
                            ),
                            SizedBox(height: 3.h),
                            C_Text(
                              text_align: TextAlign.center,
                              weight: '500',
                              font_size: 1.5,
                              color: Get_Grey,
                              text:
                                  'Oops! You are late, we went to $region, stay tuned to the next time or contact us when you are ready.',
                            )
                          ],
                        )
                      else
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: 30.h,
                              child: Image.asset('assets/six.jpeg'),
                            ),
                            SizedBox(height: 3.h),
                            C_Text(
                              weight: '500',
                              font_size: 1.9,
                              color: Get_Grey,
                              text: 'We will be there in $date',
                            )
                          ],
                        )
                    else if (status == 'Delivered')
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Image.asset('assets/happy_world.png'),
                          SizedBox(height: 3.h),
                          C_Text(
                            weight: '600',
                            color: Get_Grey,
                            font_size: 1.8,
                            text: "Thank you for helping us.",
                          ),
                        ],
                      )
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
