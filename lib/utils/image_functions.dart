//import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageFunctions {
  static Future pickImage(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      return null;
    }
  }

  static Future<Uint8List?> cameraPicker() async {
    Uint8List? image = await pickImage(ImageSource.camera);
    if (image != null) {
      return image;
    } else {
      return null;
    }
  }

  static Future<Uint8List?> galleryPicker() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 33) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.phone.request();
      }
    } else {
      status = await Permission.phone.request();
    }
    if (status.isGranted) {
      Uint8List? image = await pickImage(ImageSource.gallery);
      if (image != null) {
        return image;
      }
    }
    return null;
  }
}
