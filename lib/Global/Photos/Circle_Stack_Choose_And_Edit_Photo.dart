import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Global/Functions/Errors.dart';
import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Handle_Images.dart';

import '../../../Global/Widgets/Texts.dart';

import '../../../Global/Photos/File_And_Network_Image_Item.dart';

class Circle_Stack_Choose_And_Edit_Photo extends StatefulWidget {
  final double width;
  final XFile? file_photo;
  final String? network_image;
  final void Function(XFile?) onChoose_photo;

  const Circle_Stack_Choose_And_Edit_Photo({
    super.key,
    required this.width,
    required this.file_photo,
    this.network_image,
    required this.onChoose_photo,
  });

  @override
  State<Circle_Stack_Choose_And_Edit_Photo> createState() =>
      _Circle_Stack_Choose_And_Edit_PhotoState();
}

class _Circle_Stack_Choose_And_Edit_PhotoState
    extends State<Circle_Stack_Choose_And_Edit_Photo> {
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
        crop_style: CropStyle.circle,
        crop_aspect_ratio: const CropAspectRatio(ratioX: 1, ratioY: 1),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: Pick_Image,
            child: Padding(
              padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
              child: Circle_File_And_Network_Image_Item(
                width: widget.width,
                file_image: file_photo,
                network_image: widget.network_image,
              ),
            ),
          ),
          GestureDetector(
            onTap: Pick_Image,
            child: C_Text(
              font_size: 1.7,
              color: Get_Primary,
              weight: 'Bold',
              text: 'Choose Photo',
            ),
          ),
        ],
      ),
    );
  }
}
