import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Photos/Network_Image.dart';

import '../../../Guideline/Providers/Product_Model.dart';

class Product_Item extends StatelessWidget {
  final Product_Model product;
  const Product_Item({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
          color: Get_White,
          borderRadius: BorderRadius.all(Radius.circular(1.5.h))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            width: 10.h,
            child: Rect_Network_Image(
              image: product.photo,
            ),
          ),
          SizedBox(width: 3.w),
          C_Text(
            weight: '500',
            font_size: 1.6,
            text: product.title,
          ),
        ],
      ),
    );
  }
}
