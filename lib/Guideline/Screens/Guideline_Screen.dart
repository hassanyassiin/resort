import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/AppBar.dart';

class Guideline_Screen extends StatelessWidget {
  const Guideline_Screen({super.key});
  static const routeName = 'Guideline';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Guideline',
        leading_widget: const SizedBox()
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
      ),
    );
  }
}
