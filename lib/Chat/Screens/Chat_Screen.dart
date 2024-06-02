import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Errors.dart';
import '../../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/TextFormField.dart';
import '../../../Global/Screens/Loading_Screen.dart';

import '../../../Chat/Continued_Providers/Send_Message.dart';

class Chat_Screen extends StatefulWidget {
  const Chat_Screen({super.key});
  static const routeName = 'Chat';

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> Send_Message() async {
    if (controller.text.isEmpty) {
      return;
    }

    Loading_Screen(context: context);
    try {
      await Cd_Send_Message(text: controller.text);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        Navigator.pop(context);

        return Error_Dialog(error: error.toString(), context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Get_White,
        appBar: C_AppBar(
          title: 'Admin',
          is_show_divider: true,
          leading_widget: const SizedBox(),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 2.h, left: 2.w, right: 2.w),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: C_TextFormField(
                    controller: controller,
                    vertical_content_padding: 1.2,
                    hint_text: 'Start a message..',
                    hint_text_size: 1.75,
                  ),
                ),
                SizedBox(
                  width: 14.w,
                  child: GestureDetector(
                    onTap: Send_Message,
                    child: Container(
                      height: 4.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Get_Primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: 2.h,
                        color: Get_White,
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
