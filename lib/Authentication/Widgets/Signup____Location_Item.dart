import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Global/Functions/Infos.dart';
import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Get_Location.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Screens/Loading_Screen.dart';
import '../../../Global/Modal_Sheets/Show_Radio_Buttons_Modal_Sheet.dart';

class Signup____Location_Item extends StatefulWidget {
  final String Function() Get_Region;
  final double latitude;
  final double longitude;
  final void Function(double) Update_Latitude;
  final void Function(double) Update_Longitude;
  final void Function(String) Update_Region;

  const Signup____Location_Item({
    required this.Get_Region,
    required this.longitude,
    required this.latitude,
    required this.Update_Latitude,
    required this.Update_Longitude,
    required this.Update_Region,
    super.key,
  });

  @override
  State<Signup____Location_Item> createState() =>
      _Signup____Location_ItemState();
}

class _Signup____Location_ItemState extends State<Signup____Location_Item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () async {
                Loading_Screen(context: context);
                try {
                  var position = await Get_Location();

                  widget.Update_Longitude(position.latitude);
                  widget.Update_Latitude(position.latitude);

                  if (context.mounted) {
                    // To Popup the Loading Screen.
                    Navigator.pop(context);
                  }
                } catch (error) {
                  if (context.mounted) {
                    // To Popup the Loading Screen.
                    Navigator.pop(context);
                    return Error_Dialog(
                      context: context,
                      error: 'Something went wrong',
                    );
                  }
                }
              },
              child: Container(
                // margin: EdgeInsets.only(top: 3.h, bottom: 2.h),
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Get_Primary,
                    borderRadius: BorderRadius.all(Radius.circular(1.2.h))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(40 / 360),
                      child: Icon(
                        size: 2.h,
                        color: Get_White,
                        Icons.navigation_outlined,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    C_Text(
                      weight: '600',
                      text: 'Get Location',
                      font_size: 1.6,
                      color: Get_White,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();

                Show_Radio_Buttons_Modal_Sheets(
                  context: context,
                  initial_value: widget.Get_Region(),
                  title: 'Change Region',
                  list_items: regions,
                  onChanged: (value) => setState(() {
                    widget.Update_Region(value);
                  }),
                );
              },
              child: Container(
                // margin: EdgeInsets.only(top: 2.h, bottom: 5.h),
                padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
                decoration: BoxDecoration(
                    color: Get_Trans,
                    borderRadius: BorderRadius.all(Radius.circular(1.2.h)),
                    border: Border.all(
                        color: Get_Grey.withOpacity(0.25), width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    C_Text(
                      font_size: 1.65,
                      text: widget.Get_Region(),
                    ),
                    Icon(
                      size: 2.5.h,
                      Icons.arrow_drop_down_sharp,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
