import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Modal_Sheets/Header_For_Modal_Sheet.dart';

Future<dynamic> Show_Options_List_Tiles_Modal_Sheet({
  required String title,
  bool is_title_centered = false,
  required BuildContext context,
  required List<Map<String, dynamic>> list_tile_data,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Get_White,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2.h))),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Header_For_Modal_Sheet(
                title: title, is_title_centered: is_title_centered),
            const Divider(thickness: 0.4),
            ...list_tile_data.map((list_tile) {
              return List_Tile_With_Mini_Divider(
                icon: list_tile['Icon'],
                text: list_tile['Text'],
                onTap: list_tile['onTap'],
                icon_color: list_tile['IconColor'] ?? Get_Black,
                text_color: list_tile['TextColor'] ?? Get_Black,
              );
            }),
            SizedBox(height: 3.h),
          ],
        ),
      );
    },
  );
}

Widget List_Tile_With_Mini_Divider({
  required String text,
  required IconData icon,
  required Color icon_color,
  required Color text_color,
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
                    child: Icon(icon, size: 3.h, color: icon_color),
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
                        color: text_color,
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
