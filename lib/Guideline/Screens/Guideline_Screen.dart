import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/Failed.dart';
import '../../../Global/Widgets/AppBar.dart';

import '../../../Global/Photos/Network_Image.dart';

import '../../../Guideline/Providers/Category_Model.dart';
import '../../../Guideline/Screens/Products_Screen.dart';
import '../../../Guideline/Continued_Providers/Get_Categories.dart';

class Guideline_Screen extends StatefulWidget {
  const Guideline_Screen({super.key});
  static const routeName = 'Guideline';

  @override
  State<Guideline_Screen> createState() => _Guideline_ScreenState();
}

class _Guideline_ScreenState extends State<Guideline_Screen> {
  var is_first_request_success = false;
  List<Category_Model> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_White,
      appBar: C_AppBar(
        title: 'Guideline',
        is_show_divider: true,
        leading_widget: const SizedBox(),
      ),
      body: FutureBuilder(
        future: !is_first_request_success
            ? Cd_Get_Categories().then((received_categories) {
                categories = received_categories;
                is_first_request_success = true;
              })
            : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 1.5.h,
                color: Get_Black,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Failed_Icon_and_Text(),
            );
          } else {
            if (categories.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Center(
                  child: C_Text(
                    font_size: 1.5,
                    color: Get_Grey,
                    text: 'There is no categories yet.',
                  ),
                ),
              );
            }

            return Scrollbar(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 6.w),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 6.w,
                  crossAxisSpacing: 6.w,
                  childAspectRatio: 27.33.w / ((25.w / (1 / 1))),
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Product_Screen.routeName,
                      arguments: categories[index],
                    ),
                    child: Rect_Network_Image(
                      image: categories[index].photo,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
