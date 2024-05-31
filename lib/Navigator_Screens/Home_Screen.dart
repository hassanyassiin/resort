import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Http_Exception.dart';

import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Failed.dart';
import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Photos/Carousel_Slider.dart';

import '../../../Authentication/Providers/Authentication.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});
  static const routeName = 'Home';

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  List<Map<String, dynamic>> schedules = [];

  var is_first_request_success = false;

  Future<void> Get_Subscriptions() async {
    final url = Get_REQUEST_URL(url: '/admin-schedule/get-Schedules');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{'Authorization': 'Bearer $Get_Token'},
      );

      final response_data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw C_Http_Exception(response_data['ErrorFound'] ?? '');
      }

      List<Map<String, dynamic>> received_schedules = [];

      for (var schedule in response_data['schedules']) {
        received_schedules.add(
          {
            'Date': schedule['date'],
            'Region': schedule['region'],
          },
        );
      }

      schedules = received_schedules;
      is_first_request_success = true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final carousel_index_notifier =
        Provider.of<Carousel_Index_Notifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Home',
        leading_widget: const SizedBox(),
      ),
      body: FutureBuilder(
        future: !is_first_request_success ? Get_Subscriptions() : null,
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
              child: Failed_Icon_and_Text(),
            );
          } else {
            return ListView(
              children: <Widget>[
                Carousel_Slider(
                  images: [
                    'assets/eight.jpeg',
                    'assets/nine.jpeg',
                    'assets/ten.jpeg',
                    'assets/eleven.jpeg',
                  ],
                  carousel_index_notifier: carousel_index_notifier,
                ),
                const Divider(),
                if (schedules.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: C_Text(
                        text: 'Schedule',
                        font_size: 1.9,
                        color: Get_Black,
                        weight: '600',
                      ),
                    ),
                  ),
                if (schedules.isNotEmpty) SizedBox(height: 2.h),
                ...schedules.map(
                  (schedule) {
                    var is_same_region = Get_Region == schedule['Region'];
                    return Container(
                      margin:
                          EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: is_same_region ? Get_Primary : Get_Shein,
                        borderRadius: BorderRadius.all(Radius.circular(1.h)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          C_Text(
                            weight: '500',
                            font_size: 1.8,
                            color: is_same_region ? Get_White : Get_Black,
                            text: schedule['Region'],
                          ),
                          SizedBox(height: 1.h),
                          C_Text(
                            color: is_same_region ? Get_White : Get_Grey,
                            text: schedule['Date'],
                            weight: '500',
                            font_size: 1.5,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
