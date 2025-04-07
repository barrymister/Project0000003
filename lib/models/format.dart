/// Supported file formats and metadata
enum FormatType { markdown, plainText, yaml, restructuredText, asciidoc }

class Format {
  final FormatType type;
  final String name;
  final String extension; // with dot, e.g., '.md'
  final String description;
  final String mimeType;

  const Format({
    required this.type,
    required this.name,
    required this.extension,
    required this.description,
    required this.mimeType,
  });

  static const List<Format> allFormats = [
    Format(
      type: FormatType.markdown,
      name: 'Markdown',
      extension: '.md',
      description:
          'Widely portable and readable in text editors or platforms like GitHub.',
      mimeType: 'text/markdown',
    ),
    Format(
      type: FormatType.plainText,
      name: 'Plain Text',
      extension: '.txt',
      description:
          'Simplest output, universally compatible, no formatting overhead.',
      mimeType: 'text/plain',
    ),
    Format(
      type: FormatType.yaml,
      name: 'YAML',
      extension: '.yaml',
      description:
          'Structured data format, ideal for tech users or parsing into other systems.',
      mimeType: 'application/x-yaml',
    ),
    Format(
      type: FormatType.restructuredText,
      name: 'reStructuredText',
      extension: '.rst',
      description:
          'Richer formatting for technical documentation, convertible to HTML/PDF.',
      mimeType: 'text/x-rst',
    ),
    Format(
      type: FormatType.asciidoc,
      name: 'AsciiDoc',
      extension: '.adoc',
      description:
          'Detailed, flexible output for writing or tech docs, supported by tools like Asciidoctor.',
      mimeType: 'text/x-asciidoc',
    ),
  ];

  static Format? getByType(FormatType type) {
    return allFormats.firstWhere(
      (f) => f.type == type,
      orElse: () => allFormats.first,
    );
  }

  static Format? getByName(String name) {
    try {
      return allFormats.firstWhere(
        (f) => f.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  static Format? getByExtension(String ext) {
    final cleaned = ext.startsWith('.') ? ext : '.$ext';
    try {
      return allFormats.firstWhere(
        (f) => f.extension.toLowerCase() == cleaned.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
