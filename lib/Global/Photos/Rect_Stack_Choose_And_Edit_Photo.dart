import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Handle_Images.dart';

import '../../../Global/Photos/File_And_Network_Image_Item.dart';
import '../../../Global/Photos/Stack_Edit_And_Close_Item_For_Photo.dart';

import '../../../Global/Alert_Dialogs/Alert_Dialog.dart';

class Rect_Stack_Choose_And_Edit_Photo extends StatefulWidget {
  final double x_aspect_ratio;
  final double y_aspect_ratio;
  final String? network_image;
  final XFile? file_photo;
  final double border_radius;
  final void Function(XFile?) onChoose_photo;

  const Rect_Stack_Choose_And_Edit_Photo({
    super.key,
    this.network_image,
    this.border_radius = 0,
    required this.x_aspect_ratio,
    required this.file_photo,
    required this.y_aspect_ratio,
    required this.onChoose_photo,
  });

  @override
  State<Rect_Stack_Choose_And_Edit_Photo> createState() =>
      _Rect_Stack_Choose_And_Edit_PhotoState();
}

class _Rect_Stack_Choose_And_Edit_PhotoState
    extends State<Rect_Stack_Choose_And_Edit_Photo> {
  XFile? file_photo;

  @override
  void initState() {
    file_photo = widget.file_photo;
    super.initState();
  }

  Future<void> Pick_Image() async {
    try {
      final image = await Pick_Single_Image(context: context);

      if (image == null) {
        return;
      }

      final cropped_image = await Crop_Image(
        image: image,
        crop_aspect_ratio: CropAspectRatio(
          ratioX: widget.x_aspect_ratio,
          ratioY: widget.y_aspect_ratio,
        ),
      );

      if (cropped_image == null) {
        return;
      }

      if (mounted) {
        setState(() {
          file_photo = cropped_image;
        });
      }

      widget.onChoose_photo(cropped_image);
    } catch (error) {
      if (mounted) {
        return Error_Dialog(context: context, error: 'Picking Image');
      }
    }
  }

  Future<void> On_Edit() async {
    // To Popup if the keyboard is opened.
    FocusManager.instance.primaryFocus!.unfocus();

    try {
      final cropped_image = await Crop_Image(
          image: file_photo!,
          crop_aspect_ratio: CropAspectRatio(
            ratioX: widget.x_aspect_ratio,
            ratioY: widget.y_aspect_ratio,
          ));

      if (cropped_image == null) {
        return;
      }

      if (mounted) {
        setState(() {
          file_photo = cropped_image;
        });
      }

      widget.onChoose_photo(cropped_image);
    } catch (_) {
      if (mounted) {
        return Error_Dialog(error: 'Cropping Image', context: context);
      }
    }
  }

  Future<void> Delete_Photo() {
    // To Popup if the keyboard is opened.
    FocusManager.instance.primaryFocus!.unfocus();

    return C_Alert_Dialog(
      context: context,
      title: 'Confirm Deletion',
      content: 'This will delete the category image. Proceed?',
      button_one_title: 'Delete',
      button_one_color: Get_Red,
      is_only_one_button: false,
      button_one_function: () {
        // To pop up the alert dialog.
        Navigator.pop(context);

        setState(() {
          file_photo = null;
        });

        widget.onChoose_photo(null);
      },
      button_two_title: 'Cancel',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:
          file_photo != null ? Alignment.topCenter : Alignment.bottomRight,
      children: <Widget>[
        Rect_File_And_Network_Image(
          aspect_ratio: widget.x_aspect_ratio / widget.y_aspect_ratio,
          border_radius: widget.border_radius,
          file_image: file_photo,
          network_image: widget.network_image,
        ),
        if (file_photo == null)
          Positioned(
            bottom: 1.h,
            right: 3.w,
            child: GestureDetector(
              onTap: Pick_Image,
              child: CircleAvatar(
                backgroundColor: Get_White,
                radius: 2.4.h,
                child: CircleAvatar(
                  radius: 2.h,
                  backgroundColor: Get_Shein,
                  child: Icon(
                    size: 2.25.h,
                    Icons.camera_alt,
                    color: Get_Black,
                  ),
                ),
              ),
            ),
          ),
        if (file_photo != null)
          Stack_Edit_And_Close_Item_For_Photo(
              onEdit: On_Edit, onDelete: Delete_Photo)
      ],
    );
  }
}
