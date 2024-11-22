import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource source) async {
  try {
    XFile file = await ImagePicker().pickImage(source: source) as XFile;

    if (file != null) {
      return File(file.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
