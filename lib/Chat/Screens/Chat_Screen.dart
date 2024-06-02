import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Failed.dart';
import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/TextFormField.dart';

import '../../../Chat/Providers/Chat_Model.dart';
import '../../../Chat/Widget/Message.dart';
import '../../../Chat/Continued_Providers/Get_Chats.dart';
import '../../../Chat/Continued_Providers/Send_Message.dart';

class Chat_Screen extends StatefulWidget {
  const Chat_Screen({super.key});
  static const routeName = 'Chat';

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final controller = TextEditingController();

  var _did_change = true;

  var is_loading = false;

  List<Chat_Model> chats = [];

  var is_first_request_success = false;

  late Timer myTimer;

  var is_message_empty = true;

  @override
  void didChangeDependencies() {
    if (_did_change) {
      controller.addListener(Listener);
      myTimer =
          Timer.periodic(const Duration(seconds: 1), (timer) => Fetch_Chats());
      _did_change = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    myTimer.cancel();
    controller.dispose();
    controller.removeListener(Listener);
    super.dispose();
  }

  void Listener() {
    if (controller.text.trim().isEmpty) {
      setState(() {
        is_message_empty = true;
      });
    } else {
      setState(() {
        is_message_empty = false;
      });
    }
  }

  Future<void> Send_Message() async {
    if (controller.text.isEmpty) {
      return;
    }

    try {
      setState(() {
        is_loading = true;
      });

      await Cd_Send_Message(text: controller.text);

      if (mounted) {
        setState(() {
          is_loading = false;
          chats.add(
            Chat_Model(
              id: -1,
              text: controller.text,
              is_admin: false,
            ),
          );
          controller.clear();
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          is_loading = false;
        });
      }
    }
  }

  Future<void> Fetch_Chats() async {
    if (is_first_request_success) {
      try {
        var received_chats = await Cd_Get_Chats();

        setState(() {
          chats = received_chats;
        });
      } catch (error) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: !is_first_request_success
          ? Cd_Get_Chats().then((value) {
              chats = value;
              is_first_request_success = true;
            })
          : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading_Scaffold(
            appBar_title: 'Admin',
            is_show_appBar_divider: true,
          );
        } else if (snapshot.hasError) {
          return Failed_Scaffold(
            is_allow_refresh: true,
            is_show_appBar_divider: true,
            appBar_title: 'Admin',
            error_message: snapshot.error.toString(),
            onRefresh_tap: () => setState(() {}),
          );
        } else {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Get_White,
              appBar: C_AppBar(
                title: 'Admin',
                is_show_divider: true,
              ),
              body: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return Message(chat: chats[index]);
                },
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  color: Get_White,
                  padding: EdgeInsets.only(
                    left: 2.w,
                    right: 2.w,
                    top: 1.h,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
                  ),
                  // padding: EdgeInsets.only(bottom: 2.h, left: 2.w, right: 2.w),
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
                          onTap: is_message_empty || is_loading
                              ? null
                              : Send_Message,
                          child: Container(
                            height: 4.h,
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: is_message_empty ? Get_Grey : Get_Primary,
                              shape: BoxShape.circle,
                            ),
                            child: is_loading
                                ? CupertinoActivityIndicator(
                                    radius: 1.2.h,
                                    color: Get_Black,
                                  )
                                : Icon(
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
      },
    );
  }
}
