class TemplateField {
  final String id;
  final String label;
  final String hint;
  final bool isRequired;
  String value;

  TemplateField({
    required this.id,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.value = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'hint': hint,
      'isRequired': isRequired,
      'value': value,
    };
  }

  factory TemplateField.fromJson(Map<String, dynamic> json) {
    return TemplateField(
      id: json['id'],
      label: json['label'],
      hint: json['hint'],
      isRequired: json['isRequired'] ?? false,
      value: json['value'] ?? '',
    );
  }
}

class Template {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final String description;
  final String useCase;
  final List<TemplateField> fields;

  Template({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.description,
    required this.useCase,
    required this.fields,
  });

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

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'],
      description: json['description'],
      useCase: json['useCase'],
      fields: (json['fields'] as List)
          .map((field) => TemplateField.fromJson(field))
          .toList(),
    );
  }
}
