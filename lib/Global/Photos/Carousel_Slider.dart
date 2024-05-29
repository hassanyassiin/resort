import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Photos/Network_Image.dart';

Widget Carousel_Slider({
  required List<String> images,
  double aspect_ratio = 4.4 / 2,
  required Carousel_Index_Notifier carousel_index_notifier,
}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      CarouselSlider(
        options: CarouselOptions(
          aspectRatio: aspect_ratio,
          viewportFraction: 1,
          initialPage: carousel_index_notifier.Get_Index,
          scrollPhysics: images.length > 1
              ? const PageScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: images.length > 1 ? true : false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          // enlargeCenterPage: true,
          // enlargeFactor: 0.3,
          onPageChanged: images.length > 1
              ? (index, reason) => carousel_index_notifier.Set_Index(index)
              : null,
          scrollDirection: Axis.horizontal,
        ),
        items: images.map(
          (image) {
            return Rect_Network_Image(
              image: image,
              border_radius: 0,
              aspect_ratio: aspect_ratio,
            );
          },
        ).toList(),
      ),
      if (images.length > 1)
        Consumer<Carousel_Index_Notifier>(
          builder: (context, value, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < images.length; i++)
                Image_Index_Indicator(
                  key: ValueKey(i),
                  is_active: i == carousel_index_notifier.Get_Index,
                ),
            ],
          ),
        ),
    ],
  );
}

Widget Image_Index_Indicator({
  required bool is_active,
  required Key key,
}) {
  return Container(
    key: key,
    margin: EdgeInsets.symmetric(horizontal: 0.3.w, vertical: 1.h),
    height: is_active ? 0.55.h : 0.60.h,
    width: is_active ? 1.5.h : 0.60.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: is_active ? BoxShape.rectangle : BoxShape.circle,
      borderRadius: is_active ? BorderRadius.all(Radius.circular(4.h)) : null,
      color: is_active ? Get_White : Get_Grey90,
    ),
  );
}

class Carousel_Index_Notifier extends ChangeNotifier {
  var index = 0;
  void Set_Index(value) {
    index = value;
    notifyListeners();
  }

  int get Get_Index => index;
}
