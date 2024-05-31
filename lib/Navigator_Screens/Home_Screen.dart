import 'package:flutter/material.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/AppBar.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});
  static const routeName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Home',
        leading_widget: const SizedBox(),
      ),
    );
  }
}
