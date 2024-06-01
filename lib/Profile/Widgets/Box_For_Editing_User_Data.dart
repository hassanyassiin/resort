import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

Widget Box_For_Editing_User_Data({
  double? top_margin,
  double? bottom_margin,
  required List<Map<String, dynamic>> credentials,
}) {
  return Container(
    width: double.infinity,
    margin:
        EdgeInsets.only(top: top_margin ?? 1.h, bottom: bottom_margin ?? 1.h),
    padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.5.h),
    decoration: BoxDecoration(
      color: Get_White,
      borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
    ),
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: credentials.length,
      separatorBuilder: (context, _) => SizedBox(
          height: 2.h,
          width: double.infinity,
          child: const Divider(thickness: 0.5)),
      itemBuilder: (context, index) => SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 70.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  C_Text(
                    font_size: 1.8,
                    color: Get_BlueGrey400,
                    text: credentials[index]['UserCredentialTitle'],
                  ),
                  SizedBox(height: 1.2.h),
                  C_Text(
                    font_size: 1.7,
                    is_ltr: credentials[index]['UserCredentialTitle'] ==
                        'Phone number',
                    color: credentials[index]['UserCredentialData'] != null
                        ? Get_Black
                        : Get_Grey,
                    text: credentials[index]['UserCredentialData'] ??
                        'Add ${credentials[index]['UserCredentialTitle']} ...',
                  ),
                  SizedBox(height: 0.5.h),
                ],
              ),
            ),
            SizedBox(
              width: 15.w,
              child: GestureDetector(
                onTap: credentials[index]['onTap'],
                child: C_Text(
                  text: 'Edit',
                  font_size: 2.2,
                  color: Get_Primary,
                  text_align: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
