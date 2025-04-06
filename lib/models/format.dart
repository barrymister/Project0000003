/// Represents a file format supported by the application
class Format {
  /// The display name of the format
  final String name;
  
  /// The file extension (without the dot)
  final String extension;
  
  /// A brief description of the format
  final String description;
  
  /// The MIME type for this format
  final String mimeType;

  /// Creates a new Format instance
  const Format({
    required this.name,
    required this.extension,
    required this.description,
    this.mimeType = 'text/plain',
  });

  /// List of all supported formats
  static const List<Format> allFormats = [
    Format(
      name: 'Markdown',
      extension: 'md',
      description: 'Popular markup language for creating formatted text',
      mimeType: 'text/markdown',
    ),
    Format(
      name: 'Plain Text',
      extension: 'txt',
      description: 'Simple text without formatting',
      mimeType: 'text/plain',
    ),
    Format(
      name: 'YAML',
      extension: 'yaml',
      description: 'Human-readable data serialization format',
      mimeType: 'application/x-yaml',
    ),
    Format(
      name: 'reStructuredText',
      extension: 'rst',
      description: 'Easy-to-read plaintext markup syntax',
      mimeType: 'text/x-rst',
    ),
    Format(
      name: 'AsciiDoc',
      extension: 'adoc',
      description: 'Lightweight markup language for creating documentation',
      mimeType: 'text/x-asciidoc',
    ),
  ];
  
  /// Find a format by its name
  static Format? getByName(String name) {
    try {
      return allFormats.firstWhere(
        (format) => format.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
  
  /// Find a format by its extension
  static Format? getByExtension(String extension) {
    // Remove leading dot if present
    final ext = extension.startsWith('.') ? extension.substring(1) : extension;
    
    try {
      return allFormats.firstWhere(
        (format) => format.extension.toLowerCase() == ext.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
