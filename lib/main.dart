import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Authentication/Screens/Login_Screen.dart';
import '../../../Authentication/Providers/Authentication.dart';
import '../../../Authentication/Screens/Intro_Screen_One.dart';
import '../../../Authentication/Screens/Intro_Screen_Two.dart';
import '../../../Authentication/Screens/Intro_Screen_Three.dart';
import '../../../Authentication/Screens/Signup_Screen.dart';

import '../../../Navigator_Screens/Chat_Screen.dart';
import '../../../Navigator_Screens/Main_Screen.dart';
import '../../../Navigator_Screens/Home_Screen.dart';
import 'Profile/Screens/Profile_Screen.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Screens/Splash_Screen.dart';

import '../../../Global/Photos/Carousel_Slider.dart';

import '../../../Guideline/Screens/Products_Screen.dart';
import '../../../Guideline/Screens/Guideline_Screen.dart';

import '../../../Check_Time/Screens/Check_Time_Screen.dart';

import '../../../Profile/Providers/Profile_Model.dart';
import '../../../Profile/Screens/Edit_Profile_Pic_Screen.dart';

final navigator_key = GlobalKey<NavigatorState>();

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    return;
  };
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Get_Trans,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authentication()),
        ChangeNotifierProvider(create: (context) => Profile_Model()),
        ChangeNotifierProvider(create: (context) => Carousel_Index_Notifier()),
      ],
      child: Consumer<Authentication>(
        builder: (context, auth, child) {
          return MaterialApp(
            title: 'Resort Admin',
            themeMode: ThemeMode.light,
            navigatorKey: navigator_key,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: false),
            home: ResponsiveSizer(
              builder: (context, orientation, screenType) {
                if (auth.Is_Auth) {
                  return const Main_Screen();
                } else {
                  return FutureBuilder(
                      future:
                          !Get_Is_Try_Auto_Login ? auth.Try_Auto_Login() : null,
                      builder: (context, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const Splash_Screen()
                              : Get_Is_First_Time
                                  ? const Intro_Screen_One()
                                  : const Signup_Screen());
                }
              },
            ),
            routes: {
              Profile_Screen.routeName: (context) => const Profile_Screen(),
              Edit_Profile_Pic_Screen.routeName: (context) =>
                  const Edit_Profile_Pic_Screen(),
              Home_Screen.routeName: (context) => const Home_Screen(),
              Product_Screen.routeName: (context) => const Product_Screen(),
              Guideline_Screen.routeName: (context) => const Guideline_Screen(),
              Main_Screen.routeName: (context) => const Main_Screen(),
              Check_Time_Screen.routeName: (context) =>
                  const Check_Time_Screen(),
              Signup_Screen.routeName: (context) => const Signup_Screen(),
              Login_Screen.routeName: (context) => const Login_Screen(),
              Intro_Screen_Two.routeName: (context) => const Intro_Screen_Two(),
              Intro_Screen_Three.routeName: (context) =>
                  const Intro_Screen_Three(),
              Intro_Screen_One.routeName: (context) => const Intro_Screen_One(),
              Chat_Screen.routeName: (context) => const Chat_Screen(),
            },
          );
        },
      ),
    );
  }
}
