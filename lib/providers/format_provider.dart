import 'package:flutter/foundation.dart';
import '../models/format.dart';

/// Provides access to available formats and manages the currently selected format
class FormatProvider with ChangeNotifier {
  /// List of available formats
  final List<Format> _formats = Format.allFormats;

  List<Format> get formats => List.unmodifiable(_formats);

  Format? _selectedFormat;
  Format? get selectedFormat => _selectedFormat;

  void selectFormat(Format format) {
    _selectedFormat = format;
    notifyListeners();
  }

  /// Find a format by its name
  Format? getFormatByName(String name) {
    return Format.getByName(name);
  }

  /// Find a format by its extension
  Format? getFormatByExtension(String extension) {
    return Format.getByExtension(extension);
  }
}
