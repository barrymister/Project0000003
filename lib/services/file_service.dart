import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class FileService {
  // Save content to a file
  static Future<String?> saveFile(String content, String fileName, String extension) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        return 'Error: Storage permission denied';
      }

      // Get the downloads directory
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        return 'Error: Could not access storage';
      }

      final cosmoscribeDir = Directory(path.join(directory.path, 'Cosmoscribe'));

      // Create the directory if it doesn't exist
      if (!await cosmoscribeDir.exists()) {
        await cosmoscribeDir.create(recursive: true);
      }

      // Create the file
      final filePath = path.join(cosmoscribeDir.path, '$fileName.$extension');
      final file = File(filePath);
      await file.writeAsString(content);

      return file.path;
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Get default save location
  static Future<String?> getDefaultDirectory() async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        return null;
      }

      final cosmoscribeDir = Directory(path.join(directory.path, 'Cosmoscribe'));
      if (!await cosmoscribeDir.exists()) {
        await cosmoscribeDir.create(recursive: true);
      }

      return cosmoscribeDir.path;
    } catch (e) {
      return null;
    }
  }
}
