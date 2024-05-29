import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Widgets/AppBar.dart';

import '../../../Global/Photos/Network_Image.dart';
import '../../../Global/Photos/Show_Index_Photos_Item.dart';

class View_Image_Preview_Screen extends StatefulWidget {
  final int initial_index;
  final List<String> photos;
  final List<String>? heros;
  final void Function(int) onChanged;

  const View_Image_Preview_Screen({
    super.key,
    this.heros,
    required this.photos,
    required this.initial_index,
    required this.onChanged,
  });

  @override
  State<View_Image_Preview_Screen> createState() =>
      _View_Image_Preview_ScreenState();
}

class _View_Image_Preview_ScreenState extends State<View_Image_Preview_Screen>
    with SingleTickerProviderStateMixin {
  var default_numbers_heros = [0, 1, 2, 3, 4, 5, 6];

  List<String> default_string_heros = [];

  TextEditingController view_image_preview_index_controller =
      TextEditingController();

  late Animation<double> opacity_controller;
  late AnimationController animation_controller;

  @override
  void initState() {
    if (widget.heros != null) {
      default_string_heros = widget.heros!;
    }

    view_image_preview_index_controller.text =
        (widget.initial_index + 1).toString();

    animation_controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    opacity_controller =
        Tween(begin: 0.0, end: 1.0).animate(animation_controller);

    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      animation_controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    view_image_preview_index_controller.dispose();
    animation_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: C_AppBar(
        appBar_color: Get_Black,
        title_widget: widget.photos.length > 1
            ? FadeTransition(
                opacity: opacity_controller,
                child: Show_Index_Photos(
                  is_large_text: true,
                  bottom_margin: 0,
                  photos_length: widget.photos.length,
                  view_photo_index_controller:
                      view_image_preview_index_controller,
                ),
              )
            : null,
        leading_widget: FadeTransition(
          opacity: opacity_controller,
          child: GestureDetector(
            onTap: () {
              animation_controller.reverse();
              Navigator.pop(context);
            },
            child: UnconstrainedBox(
              child: Container(
                padding: EdgeInsets.all(0.35.h),
                decoration:
                    BoxDecoration(color: Get_Grey, shape: BoxShape.circle),
                child: Icon(Icons.close, color: Get_Black),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration.zero).then((value) {
          default_numbers_heros = [10, 11, 12, 13, 14, 15, 16];
          default_string_heros = [
            'ONE HERO',
            'TWO HERO',
            'THREE HERO',
            'FOUR HERO',
            'FIVE HERO',
            'SIX HERO',
            'SEVEN HERO'
          ];
        }),
        builder: (context, snapshot) => SafeArea(
          child: Center(
            child: AspectRatio(
              aspectRatio: 3 / 3.5,
              child: PageView.builder(
                controller: PageController(initialPage: widget.initial_index),
                itemCount: widget.photos.length,
                onPageChanged: (index) {
                  view_image_preview_index_controller.text =
                      (index + 1).toString();
                  widget.onChanged(index);
                },
                itemBuilder: (context, index) {
                  return Hero_Network_Image(
                    key: ValueKey(index),
                    image: widget.photos[index],
                    hero: default_string_heros.isNotEmpty
                        ? default_string_heros[index]
                        : default_numbers_heros[index],
                    onTap: () {},
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
