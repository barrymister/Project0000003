import '../models/format_model.dart';
import '../models/template_model.dart';

class FormatterService {
  // Convert template data to the selected format
  static String formatContent(Template template, FormatType formatType) {
    switch (formatType) {
      case FormatType.markdown:
        return _toMarkdown(template);
      case FormatType.plainText:
        return _toPlainText(template);
      case FormatType.yaml:
        return _toYaml(template);
      case FormatType.restructuredText:
        return _toRestructuredText(template);
      case FormatType.asciidoc:
        return _toAsciiDoc(template);
    }
  }

  // Convert to Markdown format
  static String _toMarkdown(Template template) {
    StringBuffer buffer = StringBuffer();
    
    // Add title
    buffer.writeln('# ${template.name}');
    buffer.writeln();
    
    // Add description
    buffer.writeln('*${template.description}*');
    buffer.writeln();
    
    // Add fields
    for (var field in template.fields) {
      if (field.value.isNotEmpty) {
        buffer.writeln('## ${field.label}');
        buffer.writeln();
        buffer.writeln(field.value);
        buffer.writeln();
      }
    }
    
    return buffer.toString();
  }

  // Convert to Plain Text format
  static String _toPlainText(Template template) {
    StringBuffer buffer = StringBuffer();
    
    // Add title
    buffer.writeln('${template.name.toUpperCase()}');
    buffer.writeln('=' * template.name.length);
    buffer.writeln();
    
    // Add description
    buffer.writeln('${template.description}');
    buffer.writeln();
    
    // Add fields
    for (var field in template.fields) {
      if (field.value.isNotEmpty) {
        buffer.writeln('${field.label.toUpperCase()}:');
        buffer.writeln('-' * (field.label.length + 1));
        buffer.writeln(field.value);
        buffer.writeln();
      }
    }
    
    return buffer.toString();
  }

  // Convert to YAML format
  static String _toYaml(Template template) {
    Map<String, dynamic> yamlMap = {
      'name': template.name,
      'category': template.category,
      'description': template.description,
    };
    
    Map<String, dynamic> fieldsMap = {};
    for (var field in template.fields) {
      if (field.value.isNotEmpty) {
        fieldsMap[field.id] = field.value;
      }
    }
    
    yamlMap['content'] = fieldsMap;
    
    // Convert to YAML string
    StringBuffer buffer = StringBuffer();
    _writeYamlMap(buffer, yamlMap, 0);
    return buffer.toString();
  }

  // Helper method to write YAML map with proper indentation
  static void _writeYamlMap(StringBuffer buffer, Map<String, dynamic> map, int indent) {
    map.forEach((key, value) {
      String indentation = ' ' * indent;
      if (value is Map) {
        buffer.writeln('$indentation$key:');
        _writeYamlMap(buffer, value, indent + 2);
      } else if (value is List) {
        buffer.writeln('$indentation$key:');
        for (var item in value) {
          buffer.writeln('$indentation- $item');
        }
      } else {
        // Handle multiline strings
        if (value is String && value.contains('\n')) {
          buffer.writeln('$indentation$key: |');
          String valueIndentation = ' ' * (indent + 2);
          for (var line in value.split('\n')) {
            buffer.writeln('$valueIndentation$line');
          }
        } else {
          buffer.writeln('$indentation$key: $value');
        }
      }
    });
  }

  // Convert to reStructuredText format
  static String _toRestructuredText(Template template) {
    StringBuffer buffer = StringBuffer();
    
    // Add title
    buffer.writeln(template.name);
    buffer.writeln('=' * template.name.length);
    buffer.writeln();
    
    // Add description
    buffer.writeln('*${template.description}*');
    buffer.writeln();
    
    // Add fields
    for (var field in template.fields) {
      if (field.value.isNotEmpty) {
        buffer.writeln(field.label);
        buffer.writeln('-' * field.label.length);
        buffer.writeln();
        buffer.writeln(field.value);
        buffer.writeln();
      }
    }
    
    return buffer.toString();
  }

  // Convert to AsciiDoc format
  static String _toAsciiDoc(Template template) {
    StringBuffer buffer = StringBuffer();
    
    // Add title
    buffer.writeln('= ${template.name}');
    buffer.writeln();
    
    // Add description
    buffer.writeln('_${template.description}_');
    buffer.writeln();
    
    // Add fields
    for (var field in template.fields) {
      if (field.value.isNotEmpty) {
        buffer.writeln('== ${field.label}');
        buffer.writeln();
        buffer.writeln(field.value);
        buffer.writeln();
      }
    }
    
    return buffer.toString();
  }
}
