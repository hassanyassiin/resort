import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/AppBar.dart';
import '../../../Global/Widgets/Failed.dart';
import '../../../Global/Widgets/Texts.dart';
import '../../../Guideline/Widgets/Product_Item.dart';

import '../../../Guideline/Providers/Category_Model.dart';
import '../../../Guideline/Providers/Product_Model.dart';
import '../../../Guideline/Continued_Providers/Get_Products.dart';

class Product_Screen extends StatefulWidget {
  const Product_Screen({super.key});
  static const routeName = 'Product-Screen';

  @override
  State<Product_Screen> createState() => _Product_ScreenState();
}

class _Product_ScreenState extends State<Product_Screen> {
  var _did_change = true;
  var is_first_request_success = false;

  late Category_Model category;
  List<Product_Model> products = [];

  @override
  void didChangeDependencies() {
    if (_did_change) {
      category = ModalRoute.of(context)!.settings.arguments as Category_Model;
      _did_change = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get_Shein,
      appBar: C_AppBar(
        title: category.title,
        appBar_color: Get_Shein,
        is_show_divider: true,
      ),
      body: FutureBuilder(
        future: !is_first_request_success
            ? Cd_Get_Products(
                category_id: category.id,
              ).then((received_products) {
                is_first_request_success = true;
                products = received_products;
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
            if (products.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Center(
                  child: C_Text(
                    font_size: 1.5,
                    color: Get_Grey,
                    text: 'There is no products yet.',
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Product_Item(product: products[index]);
              },
            );
          }
        },
      ),
    );
  }
}
