import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Chat/Screens/Chat_Screen.dart';
import '../../../Navigator_Screens/Home_Screen.dart';

import '../../../Guideline/Screens/Guideline_Screen.dart';

import '../../../Check_Time/Screens/Check_Time_Screen.dart';

import '../../../Profile/Screens/Profile_Screen.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});
  static const String routeName = '/Main';

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  var current_index = 0;

  List<Widget> tabs = [
    const Home_Screen(),
    const Guideline_Screen(),
    const Check_Time_Screen(),
    const Chat_Screen(),
    const Profile_Screen(),
  ];

  var _did_change = true;

  @override
  void didChangeDependencies() {
    if (_did_change) {
      current_index = 0;
      _did_change = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      body: tabs[current_index],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Get_Trans,
          highlightColor: Get_Trans,
        ),
        child: BottomNavigationBar(
          currentIndex: current_index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Get_White,
          elevation: 4.5,
          unselectedIconTheme:
              IconThemeData(color: Get_BlueDark50, size: 3.5.h),
          selectedIconTheme: IconThemeData(color: Get_Primary, size: 3.5.h),
          selectedLabelStyle: TextStyle(fontSize: 1.2.h),
          unselectedLabelStyle: TextStyle(fontSize: 1.2.h),
          selectedItemColor: Get_Primary,
          unselectedItemColor: Get_BlueDark90,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.3.h),
                    child: const Icon(Icons.home)),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.3.h),
                    child: const Icon(Icons.rule)),
                label: 'Guideline'),
            BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.3.h),
                    child: const Icon(Icons.check_circle)),
                label: 'Check Time'),
            BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.3.h),
                    child: const Icon(Icons.chat)),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.3.h),
                    child: const Icon(Icons.account_circle)),
                label: 'Profile'),
          ],
          onTap: (new_index) {
            setState(() {
              current_index = new_index;
            });
          },
        ),
      ),
    );
  }
}
