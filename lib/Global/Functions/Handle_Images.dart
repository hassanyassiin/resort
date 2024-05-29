import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../Global/Functions/Colors.dart';
import '../../../Global/Functions/Infos.dart';

import '../../../Global/Widgets/Toasts.dart';

import '../../../Global/Screens/Loading_Screen.dart';

bool Validate_Images({
  required List<XFile> photos,
  required BuildContext context,
}) {
  final is_valid_images_type = Validate_Images_Type(photos);

  if (is_valid_images_type.isNotEmpty) {
    Show_Images_Error_Toast(
      context: context,
      is_validate_type: true,
      files: is_valid_images_type,
    );
    return false;
  }

  final is_valid_images_size = Validate_Images_Size(photos);

  if (is_valid_images_size.isNotEmpty) {
    Show_Images_Error_Toast(
      context: context,
      is_validate_type: false,
      files: is_valid_images_size,
    );
    return false;
  }
  return true;
}

Future<XFile?> Pick_Single_Image({
  required BuildContext context,
  ImageSource image_source = ImageSource.gallery,
}) async {
  Loading_Screen(context: context);

  try {
    final image = await ImagePicker().pickImage(
      imageQuality: 100,
      source: image_source,
      requestFullMetadata: false,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (!context.mounted) {
      return null;
    }
// To Pop up the loading screen.
    Navigator.pop(context);

    if (image == null) {
      return null;
    }

    final is_validated = Validate_Images(photos: [image], context: context);

    return is_validated ? image : null;
  } catch (_) {
    if (context.mounted) {
      Navigator.pop(context);
    }
    rethrow;
  }
}

Future<List<XFile>> Pick_Multiple_Images({
  required BuildContext context,
  int allowed_photos_count = 7,
  required int stored_photos_length,
}) async {
  Loading_Screen(context: context);

  try {
    final photos = await ImagePicker()
        .pickMultiImage(requestFullMetadata: false, imageQuality: 100);

    if (!context.mounted) {
      return [];
    }

    // To Popup the Loading Screen.
    Navigator.pop(context);

    if (photos.isEmpty) {
      return [];
    }

    final get_available_photos_length =
        allowed_photos_count - stored_photos_length;

    var filtered_photos = photos.take(get_available_photos_length).toList();

    final is_validated =
        Validate_Images(photos: filtered_photos, context: context);

    return is_validated ? filtered_photos : [];
  } catch (_) {
    if (context.mounted) {
      Navigator.pop(context);
    }
    rethrow;
  }
}

Future<XFile?> Crop_Image({
  required XFile image,
  CropStyle crop_style = CropStyle.rectangle,
  String android_title = 'Edit Photo',
  String? ios_title,
  CropAspectRatio crop_aspect_ratio =
      const CropAspectRatio(ratioX: 1, ratioY: 1),
  double ios_minimum_aspect_ratio = 3 /
      2.5, // This is the aspect ratio when cropping an image to don't let the user to crop with lower aspect ratio. 3 / 2.5 because i realized that when choosing this number that whatever the CropAspectRatio is then with this number the crop box will stay the same if the user tries to make it smaller.
}) async {
  try {
    final cropped_image = await ImageCropper().cropImage(
      sourcePath: image.path,
      cropStyle: crop_style,
      compressQuality:
          99, // 99 because when making it 100 then the image will have much more size.
      aspectRatio: crop_aspect_ratio,
      uiSettings: [
        // TODO CHECK IF THE DONE WORD IN THE ANDROID CHANGED TO ARABIC,.
        AndroidUiSettings(
          toolbarTitle: android_title,
          toolbarColor: Get_White,
          toolbarWidgetColor: Get_Black,
          hideBottomControls: true,
          showCropGrid: false,
          cropGridColor: Get_Gold,
          activeControlsWidgetColor: Get_Primary,
          backgroundColor: Get_Trans,
          cropFrameColor: Get_Trans,
          dimmedLayerColor: Get_Black54,
          statusBarColor: Get_White,
        ),
        IOSUiSettings(
          title: ios_title,
          cancelButtonTitle: 'Cancel',
          doneButtonTitle: 'Done',
          rotateButtonsHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetButtonHidden: true,
          minimumAspectRatio:
              (crop_aspect_ratio.ratioX / crop_aspect_ratio.ratioY) + 0.2,
        ),
      ],
    );
    return cropped_image != null ? XFile(cropped_image.path) : null;
  } catch (_) {
    rethrow;
  }
}

List<XFile?> Validate_Images_Type(List<XFile> images) {
  List<XFile?> in_valid_files = [];

  for (int i = 0; i < images.length; i++) {
    if (!images[i].path.endsWith('png') &&
        !images[i].path.endsWith('jpeg') &&
        !images[i].path.endsWith('jpg') &&
        !images[i].path.endsWith('gif')) {
      in_valid_files.add(images[i]);
    }
  }

  return in_valid_files;
}

List<XFile?> Validate_Images_Size(List<XFile> images) {
  List<XFile?> in_valid_files = [];

  int bytes;
  double kb;
  double mb;

  for (int i = 0; i < images.length; i++) {
    bytes = File(images[i].path).readAsBytesSync().lengthInBytes;
    kb = bytes / 1024;
    mb = kb / 1024;
    if (mb > max_image_size) {
      in_valid_files.add(images[i]);
    }
  }
  return in_valid_files;
}

String Get_Image_Type(File file) {
  var image_type = '';

  if (file.path.endsWith('png')) {
    image_type = 'png';
  } else if (file.path.endsWith('jpg')) {
    image_type = 'jpg';
  } else if (file.path.endsWith('jpeg')) {
    image_type = 'jpeg';
  } else if (file.path.endsWith('gif')) {
    image_type = 'gif';
  }

  return image_type;
}
