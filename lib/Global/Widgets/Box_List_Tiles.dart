import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Texts.dart';

Widget Box_List_Tiles({
  double? top_margin,
  double? bottom_margin,
  required List<Map<String, dynamic>> list_tiles,
}) {
  return Card(
    margin:
        EdgeInsets.only(top: top_margin ?? 1.h, bottom: bottom_margin ?? 1.h),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: list_tiles.length,
        separatorBuilder: (context, _) =>
            SizedBox(height: 1.h, child: const Divider(thickness: 0.5)),
        itemBuilder: (context, index) => GestureDetector(
          onTap: list_tiles[index]['onTap'],
          child: ColoredBox(
            color: Get_Trans,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          list_tiles[index]['Prefix'],
                          size: 2.7.h,
                          color:
                              list_tiles[index]['PrefixColor'] ?? Get_Black45,
                        ),
                        SizedBox(width: 4.5.w),
                        Flexible(
                          child: C_Text(
                            font_size: 1.94,
                            text: list_tiles[index]['Title'],
                            color: list_tiles[index]['TitleColor'] ?? Get_Black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  list_tiles[index]['Suffix'] ??
                      Padding(
                        padding: EdgeInsets.only(
                          left: lang == 'Ar' ? 0 : 2.w,
                          right: lang == 'Ar' ? 2.w : 0,
                        ),
                        child: Icon(
                          size: 1.8.h,
                          color: Get_Black45,
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
