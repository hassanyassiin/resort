import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Infos.dart';
import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Modal_Sheets/Header_For_Modal_Sheet.dart';

Future<void> Show_Radio_Buttons_Modal_Sheets({
  required String title,
  required List<String> list_items,
  required BuildContext context,
  GlobalKey<FormState>? form_key,
  required String initial_value,
  TextEditingController? controller,
  required void Function(String) onChanged,
  bool is_expanded = false,
}) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Get_White,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2.h))),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Header_For_Modal_Sheet(title: title),
            const Divider(thickness: 0.4),
            if (is_expanded)
              Flexible(
                child: ListView(
                  children: <Widget>[
                    ...list_items.map((list_tile) {
                      return List_Tile_With_Mini_Divider_With_Radio_Button(
                        text: list_tile,
                        select_text: controller?.text ?? initial_value,
                        onTap: () {
                          Navigator.pop(context);

                          if (controller != null) {
                            // If controller is empty then it maybe we got an error before, so we disable the error here.
                            if (controller.text.trim().isEmpty) {
                              form_key?.currentState!.reset();
                            }

                            if (list_tile != controller.text) {
                              onChanged(list_tile);
                            }
                          } else {
                            if (list_tile != initial_value) {
                              onChanged(list_tile);
                            }
                          }
                        },
                      );
                    }),
                  ],
                ),
              )
            else
              ...list_items.map((list_tile) {
                return List_Tile_With_Mini_Divider_With_Radio_Button(
                  text: list_tile,
                  select_text: controller?.text ?? initial_value,
                  onTap: () {
                    Navigator.pop(context);

                    if (controller != null) {
                      // If controller is empty then it maybe we got an error before, so we disable the error here.
                      if (controller.text.trim().isEmpty) {
                        form_key?.currentState!.reset();
                      }

                      if (list_tile != controller.text) {
                        onChanged(list_tile);
                      }
                    } else {
                      if (list_tile != initial_value) {
                        onChanged(list_tile);
                      }
                    }
                  },
                );
              }),
            SizedBox(height: 2.h),
          ],
        ),
      );
    },
  );
}

Widget List_Tile_With_Mini_Divider_With_Radio_Button({
  required String text,
  required String select_text,
  required void Function() onTap,
}) {
  return SizedBox(
    height: 7.h,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: ColoredBox(
            color: Get_Trans,
            child: SizedBox(
              height: 6.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 16.w,
                    height: 4.h,
                    child: Icon(
                      select_text == text
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color: select_text == text ? Get_Primary : Get_Grey300,
                    ),
                  ),
                  SizedBox(
                    width: 84.w,
                    height: 4.h,
                    child: Align(
                      alignment: lang == 'Ar'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: C_Text(
                        text: text,
                        weight: '500',
                        font_size: 1.9,
                        color: Get_Black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: lang == 'Ar' ? 0 : 16.w,
            right: lang == 'Ar' ? 16.w : 0,
          ),
          child: SizedBox(
            height: 1.h,
            width: 84.w,
            child: const Divider(thickness: 0.4),
          ),
        )
      ],
    ),
  );
}
