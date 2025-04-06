import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/file_history_model.dart';

class FileHistoryProvider with ChangeNotifier {
  FileHistory _fileHistory = FileHistory();
  bool _initialized = false;

  FileHistory get fileHistory => _fileHistory;
  List<SavedFile> get recentFiles => _fileHistory.recentFiles;

  Future<void> init() async {
    if (_initialized) return;
    await _loadHistory();
    _initialized = true;
  }

  Future<void> addFile({
    required String path,
    required String name,
    required String format,
    required String templateName,
    required String categoryName,
  }) async {
    final file = SavedFile(
      path: path,
      name: name,
      format: format,
      savedAt: DateTime.now(),
      templateName: templateName,
      categoryName: categoryName,
    );
    
    _fileHistory.addFile(file);
    await _saveHistory();
    notifyListeners();
  }

  Future<void> removeFile(String path) async {
    _fileHistory.removeFile(path);
    await _saveHistory();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _fileHistory.clearHistory();
    await _saveHistory();
    notifyListeners();
  }

  Future<String> get _historyFile async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/file_history.json';
  }

  Future<void> _loadHistory() async {
    try {
      final file = File(await _historyFile);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> json = jsonDecode(contents);
        _fileHistory.loadFromJson(
          json.cast<Map<String, dynamic>>(),
        );
      }
    } catch (e) {
      debugPrint('Error loading file history: $e');
    }
  }

  Future<void> _saveHistory() async {
    try {
      final file = File(await _historyFile);
      final json = jsonEncode(_fileHistory.toJson());
      await file.writeAsString(json);
    } catch (e) {
      debugPrint('Error saving file history: $e');
    }
  }
}
