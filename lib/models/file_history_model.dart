import 'package:flutter/foundation.dart';

class SavedFile {
  final String path;
  final String name;
  final String format;
  final DateTime savedAt;
  final String templateName;
  final String categoryName;

  SavedFile({
    required this.path,
    required this.name,
    required this.format,
    required this.savedAt,
    required this.templateName,
    required this.categoryName,
  });

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'name': name,
      'format': format,
      'savedAt': savedAt.toIso8601String(),
      'templateName': templateName,
      'categoryName': categoryName,
    };
  }

  factory SavedFile.fromJson(Map<String, dynamic> json) {
    return SavedFile(
      path: json['path'] as String,
      name: json['name'] as String,
      format: json['format'] as String,
      savedAt: DateTime.parse(json['savedAt'] as String),
      templateName: json['templateName'] as String,
      categoryName: json['categoryName'] as String,
    );
  }
}

class FileHistory extends ChangeNotifier {
  List<SavedFile> _recentFiles = [];
  static const int maxRecentFiles = 50;

  List<SavedFile> get recentFiles => List.unmodifiable(_recentFiles);

  void addFile(SavedFile file) {
    // Remove if already exists to avoid duplicates
    _recentFiles.removeWhere((f) => f.path == file.path);
    
    // Add to start of list
    _recentFiles.insert(0, file);
    
    // Trim list if too long
    if (_recentFiles.length > maxRecentFiles) {
      _recentFiles = _recentFiles.sublist(0, maxRecentFiles);
    }
    
    notifyListeners();
  }

  void removeFile(String path) {
    _recentFiles.removeWhere((f) => f.path == path);
    notifyListeners();
  }

  void clearHistory() {
    _recentFiles.clear();
    notifyListeners();
  }

  // Load from JSON
  void loadFromJson(List<Map<String, dynamic>> json) {
    _recentFiles = json.map((item) => SavedFile.fromJson(item)).toList();
    notifyListeners();
  }

  // Export to JSON
  List<Map<String, dynamic>> toJson() {
    return _recentFiles.map((file) => file.toJson()).toList();
  }
}
