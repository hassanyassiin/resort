import 'package:flutter/material.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/AppBar.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});
  static const routeName = 'Profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Profile',
        leading_widget: const SizedBox(),
      ),
    );
  }
}
