import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

class FileService {
  // Save content to a file
  static Future<String?> saveFile(String content, String fileName, String extension) async {
    try {
      // Request storage permission
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (!status.isGranted) {
            return 'Storage permission denied';
          }
        }
      }

      // Get the download directory
      String? selectedDirectory;
      
      try {
        selectedDirectory = await FilePicker.platform.getDirectoryPath();
        if (selectedDirectory == null) {
          // User canceled the picker
          return null;
        }
      } catch (e) {
        // Fallback to downloads directory if directory picker fails
        final directory = await getExternalStorageDirectory();
        if (directory == null) {
          return 'Could not access storage directory';
        }
        selectedDirectory = directory.path;
      }

      // Create the file
      final file = File('$selectedDirectory/$fileName$extension');
      await file.writeAsString(content);
      
      return file.path;
    } catch (e) {
      return 'Error saving file: $e';
    }
  }

  // Get the default directory for saving files
  static Future<String?> getDefaultDirectory() async {
    try {
      if (Platform.isAndroid) {
        final directory = await getExternalStorageDirectory();
        return directory?.path;
      } else {
        final directory = await getApplicationDocumentsDirectory();
        return directory.path;
      }
    } catch (e) {
      return null;
    }
  }
}
