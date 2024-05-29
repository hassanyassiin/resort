import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Texts.dart';

Widget C_Popup_Menu_Button({
  required String tool_tip,
  required BuildContext context,
  required Widget icon,
  required List<Map<String, dynamic>> popup_menu_items,
  required void Function(dynamic) onSelected,
}) {
  return Theme(
    data: Theme.of(context).copyWith(
      highlightColor: Get_Trans,
      splashColor: Get_Trans,
    ),
    child: PopupMenuButton<int>(
      tooltip: tool_tip,
      color: Get_White,
      padding: EdgeInsets.only(
          top: -0.5
              .h), // This padding is the space between the popup menu and the popup button, when it is opened
      shadowColor: Get_Secondary,
      position: PopupMenuPosition.under,
      constraints: BoxConstraints(minWidth: 20.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(1.5.h))),
      itemBuilder: (_) => popup_menu_items
          .map(
            (popup_menu_item) => popup_menu_item['isDivider'] == true
                ? const PopupMenuDivider() as PopupMenuEntry<int>
                : PopupMenuItem<int>(
                    height: 5.h,
                    padding: EdgeInsets.only(
                      left: lang == 'Ar' ? 2.w : 4.w,
                      right: lang == 'Ar' ? 4.w : 2.w,
                    ),
                    value: popup_menu_item['Value'],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            height: 5.h,
                            child: Icon(
                              popup_menu_item['Icon'],
                              size: 2.4.h,
                              color: popup_menu_item['IconColor'] ?? Get_Black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h, width: 5.w),
                        Flexible(
                          flex: 4,
                          child: SizedBox(
                            height: 5.h,
                            child: Align(
                              alignment: lang == 'Ar'
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: C_Text(
                                text: popup_menu_item['Title'],
                                font_size: 1.9,
                                color:
                                    popup_menu_item['TitleColor'] ?? Get_Black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          )
          .toList(),
      onSelected: onSelected,
      child: icon,
    ),
  );
}
