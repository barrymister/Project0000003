enum FormatType {
  markdown,
  plainText,
  yaml,
  restructuredText,
  asciidoc,
}

class FileFormat {
  final FormatType type;
  final String name;
  final String extension;
  final String description;
  final String mimeType;

  const FileFormat({
    required this.type,
    required this.name,
    required this.extension,
    required this.description,
    required this.mimeType,
  });

  static const List<FileFormat> allFormats = [
    FileFormat(
      type: FormatType.markdown,
      name: 'Markdown',
      extension: '.md',
      description: 'Widely portable and readable in text editors or platforms like GitHub.',
      mimeType: 'text/markdown',
    ),
    FileFormat(
      type: FormatType.plainText,
      name: 'Plain Text',
      extension: '.txt',
      description: 'Simplest output, universally compatible, no formatting overhead.',
      mimeType: 'text/plain',
    ),
    FileFormat(
      type: FormatType.yaml,
      name: 'YAML',
      extension: '.yaml',
      description: 'Structured data format, ideal for tech users or parsing into other systems.',
      mimeType: 'application/x-yaml',
    ),
    FileFormat(
      type: FormatType.restructuredText,
      name: 'reStructuredText',
      extension: '.rst',
      description: 'Richer formatting for technical documentation, convertible to HTML/PDF.',
      mimeType: 'text/x-rst',
    ),
    FileFormat(
      type: FormatType.asciidoc,
      name: 'AsciiDoc',
      extension: '.adoc',
      description: 'Detailed, flexible output for writing or tech docs, supported by tools like Asciidoctor.',
      mimeType: 'text/x-asciidoc',
    ),
  ];

  static FileFormat getFormatByType(FormatType type) {
    return allFormats.firstWhere((format) => format.type == type);
  }
}
