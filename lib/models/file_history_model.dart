import 'package:flutter/foundation.dart';

class SavedFile {
  final String path;
  final String name;
  final String format;
  final String templateName;
  final String categoryName;
  final DateTime savedAt;

  SavedFile({
    required this.path,
    required this.name,
    required this.format,
    required this.templateName,
    required this.categoryName,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
    'path': path,
    'name': name,
    'format': format,
    'templateName': templateName,
    'categoryName': categoryName,
    'savedAt': savedAt.toIso8601String(),
  };

  factory SavedFile.fromJson(Map<String, dynamic> json) => SavedFile(
    path: json['path'] as String,
    name: json['name'] as String,
    format: json['format'] as String,
    templateName: json['templateName'] as String,
    categoryName: json['categoryName'] as String,
    savedAt: DateTime.parse(json['savedAt'] as String),
  );
}
