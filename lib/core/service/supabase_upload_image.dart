import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUploadImage {
  // Future<String> uploadImageToStorage(Uint8List image) async {
  //   try {
  //     // Initialize the Supabase client
  //     final supabase = Supabase.instance.client;
  //
  //     // Generate a unique file name
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //     // Specify the storage bucket (e.g., "products")
  //     String bucketName = 'images';
  //
  //     // Upload the image to the bucket
  //     final response = await supabase.storage.from(bucketName).uploadBinary(
  //           '$fileName.jpg', // File path in the bucket
  //           image, // Binary data
  //           fileOptions: const FileOptions(contentType: 'image/jpeg'),
  //         );
  //
  //     // // Check for errors in the upload response
  //     // if (response.hasError) {
  //     //   throw Exception('Failed to upload image: ${response.error!.message}');
  //     // }
  //
  //     // Get the public URL for the uploaded file
  //     final publicUrl =
  //         supabase.storage.from(bucketName).getPublicUrl('$fileName.jpg');
  //
  //     return publicUrl;
  //   } catch (e) {
  //     throw Exception('Failed to upload image: $e');
  //   }
  // }

  Future<String> uploadImageToStorage(
      {required Uint8List image, required String filePathName}) async {
    try {
      // Initialize the Supabase client
      final supabase = Supabase.instance.client;

      // Generate a unique file name
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Specify the storage bucket and file path
      String bucketName = 'images';
      String filePath =
          '$filePathName/$fileName.jpg'; // File inside "products" directory

      // Upload the image to the bucket
      await supabase.storage.from(bucketName).uploadBinary(
            filePath, // File path in the bucket
            image, // Binary data
            fileOptions: const FileOptions(contentType: 'image/jpeg'),
          );

      // Get the public URL for the uploaded file
      final publicUrl =
          supabase.storage.from(bucketName).getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
