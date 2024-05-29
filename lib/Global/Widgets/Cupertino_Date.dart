import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';

Future<void> Show_Cupertino_Date_Picker_ModalSheet({
  required String day,
  required BuildContext context,
  required TextEditingController tapped_controller,
}) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Get_White,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(2.h)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 2.5.h, bottom: 0.8.h, right: 4.w, left: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  C_Text(
                    text: day,
                    font_size: 2.1,
                    weight: '500',
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: C_Text(
                      text: 'Done',
                      font_size: 2,
                      weight: '500',
                      color: Get_Primary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.5),
            SizedBox(height: 1.h),
            C_Cupertino_Date(tapped_controller: tapped_controller),
          ],
        ),
      );
    },
  );
}

Widget C_Cupertino_Date({required TextEditingController tapped_controller}) {
  return SizedBox(
    height: 20.h,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 22.w),
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: Get_Black,
              fontSize: 2.h,
              height: 1.15,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: tapped_controller.text.isNotEmpty
              ? DateFormat("dd MMMM yy").parse(tapped_controller.text)
              : DateFormat("dd MMMM yy").parse(
                  '${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}'),
          // dateOrder: DatePickerDateOrder.dmy,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (date) =>
              tapped_controller.text = DateFormat("dd MMMM yyyy").format(date),
        ),
      ),
    ),
  );
}
