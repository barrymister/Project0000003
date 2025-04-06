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
      hint: 'Enter $fieldName',
    );
  }
}

/// Represents a document template in the application
class Template {
  /// Unique identifier for the template
  final String id;
  
  /// Display name of the template
  final String name;
  
  /// Category the template belongs to
  final String category;
  
  /// Optional subcategory for more specific grouping
  final String subcategory;
  
  /// Brief description of the template
  final String description;
  
  /// Example use case for this template
  final String useCase;
  
  /// Fields that make up this template
  final List<TemplateField> fields;

  /// Creates a new template
  Template({
    String? id,
    required this.name,
    required this.category,
    this.subcategory = '',
    this.description = '',
    this.useCase = '',
    List<TemplateField>? fields,
    List<String>? fieldNames,
  }) : 
    this.id = id ?? name.toLowerCase().replaceAll(' ', '_'),
    this.fields = fields ?? 
      (fieldNames?.map((name) => TemplateField.fromString(name)).toList() ?? []);

  /// Convert template to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'description': description,
      'useCase': useCase,
      'fields': fields.map((field) => field.toJson()).toList(),
    };
  }

  /// Create a template from JSON data
  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'] ?? '',
      description: json['description'] ?? '',
      useCase: json['useCase'] ?? '',
      fields: (json['fields'] as List?)
          ?.map((field) => TemplateField.fromJson(field))
          .toList() ?? [],
    );
  }

  /// Create a simple template from basic information
  factory Template.simple({
    required String name,
    required String category,
    required List<String> fieldNames,
  }) {
    return Template(
      name: name,
      category: category,
      fieldNames: fieldNames,
    );
  }
}
