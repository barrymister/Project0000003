import 'package:flutter/foundation.dart';
import '../models/template.dart';
import '../constants/template_data.dart';

/// Provides access to available templates and manages the currently selected template
class TemplateProvider with ChangeNotifier {
  /// The currently selected template
  Template? _selectedTemplate;

  /// Get the currently selected template
  Template? get selectedTemplate => _selectedTemplate;

  /// List of all available categories
  List<String> get categories =>
      TemplateData.allTemplates
          .map((template) => template.category)
          .toSet()
          .toList();

  /// Select a template and notify listeners
  void selectTemplate(Template template) {
    _selectedTemplate = template;
    notifyListeners();
  }

  /// Get all templates for a specific category
  List<Template> getTemplatesByCategory(String category) {
    return TemplateData.getTemplatesByCategory(category);
  }

  /// Find a template by its name
  Template? getTemplateByName(String name) {
    try {
      return TemplateData.allTemplates.firstWhere(
        (template) => template.name == name,
      );
    } catch (e) {
      return null;
    }
  }

  /// Find a template by its ID
  Template? getTemplateById(String id) {
    return TemplateData.getTemplateById(id);
  }
}
