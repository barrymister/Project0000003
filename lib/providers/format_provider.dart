import 'package:flutter/foundation.dart';
import '../models/format.dart';

// Define available formats
const List<Format> _availableFormats = [
  Format(
    name: 'Markdown',
    extension: 'md',
    description: 'Popular markup language for creating formatted text',
  ),
  Format(
    name: 'Plain Text',
    extension: 'txt',
    description: 'Simple text without formatting',
  ),
  Format(
    name: 'YAML',
    extension: 'yaml',
    description: 'Human-readable data serialization format',
  ),
  Format(
    name: 'reStructuredText',
    extension: 'rst',
    description: 'Easy-to-read plaintext markup syntax',
  ),
  Format(
    name: 'AsciiDoc',
    extension: 'adoc',
    description: 'Lightweight markup language for creating documentation',
  ),
];

class FormatProvider with ChangeNotifier {
  final List<Format> _formats = _availableFormats;

  List<Format> get formats => List.unmodifiable(_formats);

  Format? _selectedFormat;
  Format? get selectedFormat => _selectedFormat;

  void selectFormat(Format format) {
    _selectedFormat = format;
    notifyListeners();
  }

  Format? getFormatByName(String name) {
    try {
      return _formats.firstWhere((f) => f.name == name);
    } catch (e) {
      return null;
    }
  }

  Format? getFormatByExtension(String extension) {
    try {
      return _formats.firstWhere((f) => f.extension == extension);
    } catch (e) {
      return null;
    }
  }
}
