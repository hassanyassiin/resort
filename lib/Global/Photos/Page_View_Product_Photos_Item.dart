import 'package:flutter/material.dart';

import '../../../Global/Functions/Colors.dart';

import '../../../Global/Helpers/Custom_Route.dart';

import '../../../Global/Photos/Network_Image.dart';
import '../../../Global/Photos/Show_Index_Photos_Item.dart';
import '../../../Global/Photos/View_Image_Preview_Screen.dart';

class Page_View_Product_Photos_Item extends StatefulWidget {
  final List<String> photos;
  final TextEditingController view_photo_index_controller;

  const Page_View_Product_Photos_Item({
    required this.photos,
    required this.view_photo_index_controller,
    super.key,
  });

  @override
  State<Page_View_Product_Photos_Item> createState() =>
      _Page_View_Product_Photos_ItemState();
}

class _Page_View_Product_Photos_ItemState
    extends State<Page_View_Product_Photos_Item> {
  final PageController page_controller = PageController();

  List<String> recent_photos = [];

  @override
  void initState() {
    recent_photos.addAll(widget.photos);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    page_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Get_Shein, width: 0.2),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 3 / 3.5,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView.builder(
              physics: widget.photos.length == 1
                  ? const NeverScrollableScrollPhysics()
                  : const PageScrollPhysics(),
              controller: page_controller,
              itemCount: widget.photos.length,
              onPageChanged: (index) => widget
                  .view_photo_index_controller.text = (index + 1).toString(),
              itemBuilder: (context, index) {
                return FutureBuilder(
                  key: ValueKey(index),
                  future: Future.delayed(Duration.zero).then((value) {
                    // HON AAM BEFTOROD AND ENO L USER HAYDAR L PHOTOS B PHOTOS A2AL LENGTH SO WHEN THE NOTIFY LISTENER APPEAR THEN IT WILL ANIMATE TO THE FIRST INDEX.
                    if (recent_photos.toString() != widget.photos.toString()) {
                      recent_photos = [];
                      recent_photos.addAll(widget.photos);
                      page_controller.animateTo(1,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.ease);
                    }
                  }),
                  builder: (context, snapshot) {
                    return Hero_Network_Image(
                      hero: widget.photos[index], // IT WAS INDEX INSTEAD
                      image: widget.photos[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          Custom_Fade_and_Slide_Route(
                            screen: View_Image_Preview_Screen(
                              photos: widget.photos,
                              heros: widget.photos, // IT WAS NULL INSTEAD
                              initial_index: index,
                              onChanged: (value) =>
                                  page_controller.animateToPage(
                                value,
                                curve: Curves.easeIn,
                                duration: const Duration(microseconds: 1),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            if (widget.photos.length > 1)
              Show_Index_Photos(
                photos_length: widget.photos.length,
                view_photo_index_controller: widget.view_photo_index_controller,
              ),
          ],
        ),
      ),
    );
  }
}
