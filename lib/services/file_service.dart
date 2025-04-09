import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'logger_service.dart';

class FileService {
  // Save content to a file
  static Future<String?> saveFile(String content, String fileName, String extension) async {
    final logger = LoggerService();
    logger.log('Attempting to save file: $fileName.$extension', level: LogLevel.info);
    try {
      // Request appropriate permissions based on Android version
      if (!kIsWeb && Platform.isAndroid) {
        logger.log('Requesting Android storage permissions');

        // Request both storage permissions to ensure compatibility across Android versions
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
          Permission.manageExternalStorage,
        ].request();
        
        // Check if at least one permission is granted
        if (!statuses.values.any((status) => status.isGranted)) {
          logger.logError('Storage permission denied');

          return 'Error: Storage permission denied. Please grant storage permissions in app settings.';
        }
      }

      // Get the application documents directory
      Directory? directory;
      logger.log('Getting storage directory');
      try {
        directory = await getExternalStorageDirectory();
      } catch (e) {
        // Fallback to application documents directory if external storage is not available
        directory = await getApplicationDocumentsDirectory();
      }
      
      if (directory == null) {
        logger.logError('Could not access any storage directory');
        return 'Error: Could not access storage';
      }
      
      logger.log('Using directory: ${directory.path}');

      final cosmoscribeDir = Directory(path.join(directory.path, 'Cosmoscribe'));

      // Create the directory if it doesn't exist
      if (!await cosmoscribeDir.exists()) {
        logger.log('Creating Cosmoscribe directory at: ${cosmoscribeDir.path}');
        await cosmoscribeDir.create(recursive: true);
      }

      // Sanitize filename to remove invalid characters
      final sanitizedFileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      if (sanitizedFileName != fileName) {
        logger.log('Filename sanitized: $fileName -> $sanitizedFileName');
      }
      
      // Create the file
      final filePath = path.join(cosmoscribeDir.path, '$sanitizedFileName.$extension');
      logger.log('Writing file to: $filePath');
      final file = File(filePath);
      await file.writeAsString(content);
      logger.log('File saved successfully: $filePath');

      return file.path;
    } catch (e, stackTrace) {
      logger.logError('Error saving file', e, stackTrace);
      return 'Error: $e';
    }
  }

  // Get default save location
  static Future<String?> getDefaultDirectory() async {
    final logger = LoggerService();
    logger.log('Getting default directory');
    try {
      Directory? directory;
      try {
        directory = await getExternalStorageDirectory();
      } catch (e) {
        // Fallback to application documents directory if external storage is not available
        directory = await getApplicationDocumentsDirectory();
      }
      
      if (directory == null) {
        return null;
      }

      final cosmoscribeDir = Directory(path.join(directory.path, 'Cosmoscribe'));
      if (!await cosmoscribeDir.exists()) {
        await cosmoscribeDir.create(recursive: true);
      }

      return cosmoscribeDir.path;
    } catch (e, stackTrace) {
      logger.logError('Error getting default directory', e, stackTrace);
      return null;
    }
  }
}
