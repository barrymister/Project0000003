/// Represents a field in a template form
class TemplateField {
  /// Unique identifier for the field
  final String id;

  /// Display label for the field
  final String label;

  /// Hint text to guide the user
  final String hint;

  /// Whether this field must be filled
  final bool isRequired;

  /// Current value of the field
  String value;

  /// Creates a new template field
  TemplateField({
    required this.id,
    required this.label,
    this.hint = '',
    this.isRequired = false,
    this.value = '',
  });

  /// Convert field to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'hint': hint,
      'isRequired': isRequired,
      'value': value,
    };
  }

  /// Create a field from JSON data
  factory TemplateField.fromJson(Map<String, dynamic> json) {
    return TemplateField(
      id: json['id'],
      label: json['label'],
      hint: json['hint'] ?? '',
      isRequired: json['isRequired'] ?? false,
      value: json['value'] ?? '',
    );
  }

  /// Create a field from a simple string
  factory TemplateField.fromString(String fieldName) {
    return TemplateField(
      id: fieldName.toLowerCase().replaceAll(' ', '_'),
      label: fieldName,
    );
  }
}

/// Represents a content template with metadata and fields
class Template {
  final String id;
  final String name;
  final String category;
  final String? subcategory;
  final String? description;
  final String? useCase;
  final List<TemplateField> fields;

  Template({
    required this.id,
    required this.name,
    required this.category,
    this.subcategory,
    this.description,
    this.useCase,
    required this.fields,
  });

  /// Convert template to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'description': description,
      'useCase': useCase,
      'fields': fields.map((f) => f.toJson()).toList(),
    };
  }

  /// Create template from JSON
  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'],
      description: json['description'],
      useCase: json['useCase'],
      fields:
          (json['fields'] as List<dynamic>)
              .map((f) => TemplateField.fromJson(f))
              .toList(),
    );
  }
}
