import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/file_history_model.dart';

class FileHistoryProvider with ChangeNotifier {
  static const String _storageKey = 'file_history';
  SharedPreferences? _prefs;
  final List<SavedFile> _recentFiles = [];

  FileHistoryProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadHistory();
  }

  Future<void> _loadHistory() async {
    final jsonString = _prefs?.getString(_storageKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _recentFiles.clear();
      _recentFiles.addAll(
        jsonList.map((item) => SavedFile.fromJson(item)).toList(),
      );
      notifyListeners();
    }
  }

  Future<void> _saveHistory() async {
    if (_prefs != null) {
      final jsonString = json.encode(
        _recentFiles.map((file) => file.toJson()).toList(),
      );
      await _prefs!.setString(_storageKey, jsonString);
    }
  }

  List<SavedFile> get recentFiles => List.unmodifiable(_recentFiles);

  Future<void> init() async {
    if (_recentFiles.isNotEmpty) return;
    await _loadHistory();
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
      templateName: templateName,
      categoryName: categoryName,
      savedAt: DateTime.now(),
    );
    
    // Remove any existing file with the same path
    _recentFiles.removeWhere((f) => f.path == path);
    
    // Add the new file at the beginning
    _recentFiles.insert(0, file);
    
    // Keep only the last 50 files
    if (_recentFiles.length > 50) {
      _recentFiles.removeLast();
    }
    
    await _saveHistory();
    notifyListeners();
  }

  Future<void> removeFile(String path) async {
    _recentFiles.removeWhere((file) => file.path == path);
    await _saveHistory();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _recentFiles.clear();
    await _saveHistory();
    notifyListeners();
  }
}
