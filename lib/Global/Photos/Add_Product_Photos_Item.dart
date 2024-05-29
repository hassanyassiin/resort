import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Handle_Images.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Photos/Add_Or_Edit_Photos_For_Modal_Sheet.dart';
import '../../../Global/Photos/Generating_Boxes_For_Adding_Or_Editing_Photos.dart';

class Add_Product_Photos_Item extends StatefulWidget {
  final String? title;
  final List<XFile> Function() get_product_file_photos;
  final void Function(List<XFile>) set_product_file_photos;
  final int allow_photos_count;
  final double aspect_ratio_x;
  final double aspect_ratio_y;
  final double width;
  final bool is_for_review;
  final double modal_sheet_width;

  const Add_Product_Photos_Item({
    this.title,
    this.allow_photos_count = 7,
    required this.get_product_file_photos,
    required this.set_product_file_photos,
    this.is_for_review = false,
    this.aspect_ratio_x = 3,
    this.aspect_ratio_y = 3.5,
    this.width = 27,
    this.modal_sheet_width = 88,
    super.key,
  });

  @override
  State<Add_Product_Photos_Item> createState() =>
      _Add_Product_Photos_ItemState();
}

class _Add_Product_Photos_ItemState extends State<Add_Product_Photos_Item> {
  Future<void> Pick_New_Photo() async {
    try {
      final filtered_editing_product_file_photos = await Pick_Multiple_Images(
        context: context,
        allowed_photos_count: widget.allow_photos_count,
        stored_photos_length: widget.get_product_file_photos().length,
      );

      if (!mounted) {
        return;
      }

      if (filtered_editing_product_file_photos.isEmpty) {
        return;
      }

      return showModalBottomSheet(
        isDismissible: false,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (ctx) => Add_Or_Edit_Photos_For_Modal_Sheet(
          aspect_ratio_x: widget.aspect_ratio_x,
          aspect_ratio_y: widget.aspect_ratio_y,
          width: widget.modal_sheet_width,
          photos: filtered_editing_product_file_photos,
          onTap: () {
            // If the user cleared all new editing photos there is no need to update the screen or add them to the main list.
            if (filtered_editing_product_file_photos.isEmpty) {
              return Navigator.pop(context);
            }

            setState(() {
              widget.set_product_file_photos([
                ...widget.get_product_file_photos(),
                ...filtered_editing_product_file_photos,
              ]);
            });
            Navigator.pop(context);
          },
        ),
      );
    } catch (_) {
      if (mounted) {
        return Error_Dialog(context: context, error: 'Picking Image');
      }
    }
  }

  Future<void> Edit_Photos() async {
    List<XFile> edited_product_file_photos = [];
    edited_product_file_photos.addAll(widget.get_product_file_photos());

    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) => Add_Or_Edit_Photos_For_Modal_Sheet(
        is_edit: true,
        aspect_ratio_x: widget.aspect_ratio_x,
        aspect_ratio_y: widget.aspect_ratio_y,
        width: widget.modal_sheet_width,
        photos: edited_product_file_photos,
        onTap: () {
          if (edited_product_file_photos.isEmpty) {
            setState(() {
              widget.set_product_file_photos([]);
            });
            // To Popup the Modal sheet.
            return Navigator.pop(context);
          }

          setState(() {
            widget.set_product_file_photos([
              ...edited_product_file_photos,
            ]);
          });
          // To Popup the Modal sheet.
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 1.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Generating_Boxes_For_Adding_Or_Editing_Photos(
            title: widget.title ?? 'Photos',
            width: widget.width,
            onEdit: Edit_Photos,
            onPick: Pick_New_Photo,
            is_for_review: widget.is_for_review,
            aspect_ratio_x: widget.aspect_ratio_x,
            aspect_ratio_y: widget.aspect_ratio_y,
            photos: widget.get_product_file_photos(),
            max_photos_count: widget.allow_photos_count,
          ),
          if (!widget.is_for_review)
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
              child: C_Text(
                color: Get_Grey,
                weight: '400',
                font_size: 1.5,
                text:
                    '${'Kindly add at least 1 image and no more than'} ${widget.allow_photos_count} ${'images'}.',
              ),
            ),
        ],
      ),
    );
  }
}
