import 'package:flutter/material.dart';
import '../models/format_model.dart';
import '../models/template_model.dart';

class TemplateProvider extends ChangeNotifier {
  Template? _selectedTemplate;
  
  Template? get selectedTemplate => _selectedTemplate;
  
  void selectTemplate(Template template) {
    _selectedTemplate = template;
    notifyListeners();
  }
  
  void updateTemplateField(String fieldId, String value) {
    if (_selectedTemplate != null) {
      final fieldIndex = _selectedTemplate!.fields.indexWhere((field) => field.id == fieldId);
      if (fieldIndex != -1) {
        _selectedTemplate!.fields[fieldIndex].value = value;
        notifyListeners();
      }
    }
  }
  
  void clearSelectedTemplate() {
    _selectedTemplate = null;
    notifyListeners();
  }
}

class FormatProvider extends ChangeNotifier {
  FormatType _selectedFormatType = FormatType.markdown;
  
  FormatType get selectedFormatType => _selectedFormatType;
  FileFormat get selectedFormat => FileFormat.getFormatByType(_selectedFormatType);
  
  void selectFormat(FormatType formatType) {
    _selectedFormatType = formatType;
    notifyListeners();
  }
}
