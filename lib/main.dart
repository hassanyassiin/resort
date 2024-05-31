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
import '../../../Navigator_Screens/Users_Screen.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Screens/Splash_Screen.dart';

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
              Users_Screen.routeName: (context) => const Users_Screen(),
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
