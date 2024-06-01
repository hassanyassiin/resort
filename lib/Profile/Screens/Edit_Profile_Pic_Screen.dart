import 'package:flutter/material.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/AppBar.dart';

class Edit_Profile_Pic_Screen extends StatelessWidget {
  const Edit_Profile_Pic_Screen({super.key});
  static const routeName = 'Edit-Profile-Pic-Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(title: 'Edit Profile Pic'),
    );
  }
}
