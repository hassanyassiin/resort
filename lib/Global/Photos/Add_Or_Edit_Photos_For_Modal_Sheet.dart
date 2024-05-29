import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Handle_Inputs.dart';
import '../../../Global/Functions/Handle_Images.dart';

import '../../../Global/Widgets/Texts.dart';
import '../../../Global/Widgets/Buttons.dart';

import '../../../Global/Photos/Stack_Edit_Image.dart';

import '../../../Global/Alert_Dialogs/Alert_Dialog.dart';

class Add_Or_Edit_Photos_For_Modal_Sheet extends StatefulWidget {
  final List<XFile> photos;
  final void Function() onTap;
  final bool is_edit;
  final double aspect_ratio_x;
  final double aspect_ratio_y;
  final double width;

  const Add_Or_Edit_Photos_For_Modal_Sheet({
    required this.photos,
    required this.onTap,
    this.is_edit = false,
    required this.aspect_ratio_x,
    required this.aspect_ratio_y,
    required this.width,
    super.key,
  });

  @override
  State<Add_Or_Edit_Photos_For_Modal_Sheet> createState() =>
      _Add_Or_Edit_Photos_For_Modal_SheetState();
}

class _Add_Or_Edit_Photos_For_Modal_SheetState
    extends State<Add_Or_Edit_Photos_For_Modal_Sheet> {
  final scroll_controller = ScrollController();

  @override
  void dispose() {
    scroll_controller.dispose();
    super.dispose();
  }

  Future<void> On_Edit(int index) async {
    try {
      final cropped_image = await Crop_Image(
        image: widget.photos[index],
        crop_aspect_ratio: CropAspectRatio(
            ratioX: widget.aspect_ratio_x, ratioY: widget.aspect_ratio_y),
      );

      if (cropped_image == null) {
        return;
      }

      setState(() {
        widget.photos[index] = cropped_image;
      });
    } catch (error) {
      if (mounted) {
        return Error_Dialog(context: context, error: 'Cropping Image');
      }
    }
  }

  Future<void> On_Delete(XFile photo) async {
    if (widget.photos.length == 1) {
      return C_Alert_Dialog(
        context: context,
        title: widget.is_edit ? 'Delete & Save ?' : 'Delete & Exit',
        content: widget.is_edit
            ? 'Are you sure you want to clear all photos ?'
            : 'Are you sure you want to delete photo',
        is_only_one_button: false,
        button_one_title: widget.is_edit ? 'Clear All' : 'Delete & Exit',
        button_one_color: Get_Red,
        button_one_function: () {
          // To Popup the Alert Dialog.
          Navigator.pop(context);

          widget.photos.remove(photo);

          // Calling onTap to clear the the main photos array.
          //Then it will close the Modal sheet.
          widget.onTap();
        },
        button_two_title: 'Cancel',
      );
    } else {
      setState(() {
        widget.photos.remove(photo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 4.h, top: 1.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.add, color: Get_Trans),
                  C_Text(
                    weight: '600',
                    font_size: 2.2,
                    text: widget.is_edit ? 'Edit Photos' : 'New Photos',
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.cancel_rounded, color: Get_Grey),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              if (widget.photos.length == 1)
                SizedBox(
                  height: widget.width.w /
                      (widget.aspect_ratio_x / widget.aspect_ratio_y),
                  child: Stack_Edit_Image(
                    width: 85,
                    left_padding: 7,
                    right_padding: 7,
                    border_radius: 1.4,
                    aspect_ratio_x: widget.aspect_ratio_x,
                    aspect_ratio_y: widget.aspect_ratio_y,
                    key: ValueKey(Generate_32_Random_Numbers()),
                    image: widget.photos[0],
                    onDelete: () => On_Delete(widget.photos[0]),
                    onEdit: () => On_Edit(0),
                  ),
                ),
              if (widget.photos.length > 1)
                SizedBox(
                  height: widget.width.w /
                      (widget.aspect_ratio_x / widget.aspect_ratio_y),
                  child: Scrollbar(
                    trackVisibility: true,
                    thumbVisibility: true,
                    controller: scroll_controller,
                    child: ListView.builder(
                      controller: scroll_controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.photos.length,
                      itemBuilder: (context, index) {
                        return Stack_Edit_Image(
                          width: 85,
                          left_padding: 3,
                          border_radius: 1.4,
                          right_padding:
                              index == widget.photos.length - 1 ? 3 : 0,
                          key: ValueKey(Generate_32_Random_Numbers()),
                          image: widget.photos[index],
                          aspect_ratio_x: widget.aspect_ratio_x,
                          aspect_ratio_y: widget.aspect_ratio_y,
                          onDelete: () => On_Delete(widget.photos[index]),
                          onEdit: () => On_Edit(index),
                        );
                      },
                    ),
                  ),
                ),
              C_Rounded_Button(
                onPressed: widget.onTap,
                border_radius: 0,
                title: widget.is_edit ? 'Update Photos' : 'Add Photos',
                button_color: Get_Black,
              ),
              C_Text(
                font_size: 1.5,
                weight: '500',
                color: Get_Grey,
                text:
                    'Make sure to add the photos with a high quality to let the user attract more to you products.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
