import 'package:flutter/material.dart';

import '../../../Global/Functions/Colors.dart';
import '../../Global/Widgets/AppBar.dart';

class Chat_Screen extends StatefulWidget {
  const Chat_Screen({super.key});
  static const routeName = 'Chat';

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(),
    );
  }
}
