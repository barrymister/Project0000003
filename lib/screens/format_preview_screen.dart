import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../providers/template_provider.dart';
import '../providers/format_provider.dart';
import '../providers/file_history_provider.dart';
import '../services/file_service.dart';
import '../services/logger_service.dart';
import '../models/format.dart';
import '../models/template.dart';

class FormatPreviewScreen extends StatefulWidget {
  const FormatPreviewScreen({super.key});

  @override
  State<FormatPreviewScreen> createState() => _FormatPreviewScreenState();
}

class _FormatPreviewScreenState extends State<FormatPreviewScreen> {
  String _fileName = '';
  bool _isSaving = false;
  String? _saveResult;
  String? _saveLocation;

  Future<void> _updateSaveLocation() async {
    final location = await FileService.getDefaultDirectory();
    if (location != null) {
      setState(() {
        _saveLocation = '$location/Cosmoscribe';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateSaveLocation();
    // Initialize filename based on template
    final templateProvider = Provider.of<TemplateProvider>(
      context,
      listen: false,
    );
    final template = templateProvider.selectedTemplate;
    if (template != null) {
      _fileName = template.name.replaceAll(' ', '_').toLowerCase();
    } else {
      _fileName = 'cosmoscribe_document';
    }
  }

  @override
  Widget build(BuildContext context) {
    final templateProvider = Provider.of<TemplateProvider>(context);
    final formatProvider = Provider.of<FormatProvider>(context);

    final template = templateProvider.selectedTemplate;
    if (template == null) {
      // Handle case where no template is selected (shouldn't happen normally)
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No template selected')),
      );
    }

    final format = formatProvider.selectedFormat;

    // Generate formatted content
    String formattedContent = '';
    if (template != null) {
      formattedContent = '''
# ${template.name}

## Fields
${template.fields.map((field) => '- $field').join('\n')}
''';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Preview & Save'), centerTitle: true),
      body: Column(
        children: [
          _buildFormatSelector(context, formatProvider),
          _buildFileNameInput(context),
          Expanded(child: _buildPreview(context, formattedContent)),
          if (format != null)
            _buildBottomBar(context, template, formattedContent, format),
        ],
      ),
    );
  }

  Widget _buildFormatSelector(
    BuildContext context,
    FormatProvider formatProvider,
  ) {
    final selectedFormat = formatProvider.selectedFormat;
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Format', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  formatProvider.formats.map((format) {
                    final isSelected = selectedFormat?.name == format.name;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ChoiceChip(
                        label: Text(format.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            formatProvider.selectFormat(format);
                          }
                        },
                        backgroundColor:
                            isSelected
                                ? Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.1)
                                : null,
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          if (selectedFormat != null)
            Text(
              selectedFormat.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }

  Widget _buildFileNameInput(BuildContext context) {
    final saveLocationText =
        _saveLocation != null
            ? 'File will be saved to: $_saveLocation'
            : 'Preparing save location...';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'File Name',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: _fileName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter file name (without extension)',
            ),
            onChanged: (value) {
              setState(() {
                _fileName = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Text(
            saveLocationText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(BuildContext context, String content) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.preview, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                'Preview',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 16),
              ),
            ],
          ),
          const Divider(),
          Expanded(child: _buildPreviewContent(context, content)),
        ],
      ),
    );
  }

  Widget _buildPreviewContent(BuildContext context, String content) {
    final formatProvider = context.read<FormatProvider>();
    final selectedFormat = formatProvider.selectedFormat;

    // For Markdown, use the flutter_markdown package
    if (selectedFormat?.name.toLowerCase() == 'markdown') {
      return Markdown(data: content, selectable: true);
    }

    // For other formats, just show as plain text
    return SingleChildScrollView(
      child: SelectableText(
        content,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    Template template,
    String content,
    Format format,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (_saveResult != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _saveResult!,
                style: TextStyle(
                  color:
                      _saveResult!.startsWith('Error')
                          ? Colors.red
                          : Colors.green,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      _isSaving
                          ? null
                          : () => _saveFile(context, template, content, format),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child:
                      _isSaving
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text('Save to Device'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveFile(
    BuildContext context,
    Template template,
    String content,
    Format format,
  ) async {
    final logger = LoggerService();
    logger.log('Save file requested: $_fileName.${format.extension}');
    
    if (_fileName.isEmpty) {
      logger.logWarning('Save attempted with empty filename');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a file name')));
      return;
    }

    setState(() {
      _isSaving = true;
      _saveResult = null;
    });
    
    logger.log('Starting file save process');
    logger.log('Template: ${template.name}');
    logger.log('Format: ${format.name}');
    logger.log('Content length: ${content.length} characters');

    try {
      logger.log('Calling FileService.saveFile');
      final result = await FileService.saveFile(
        content,
        _fileName,
        format.extension,
      );
      
      logger.log('FileService.saveFile result: $result');

      if (result != null && !result.startsWith('Error')) {
        logger.log('File saved successfully at: $result');
        
        // Add to file history
        logger.log('Adding file to history');
        Provider.of<FileHistoryProvider>(context, listen: false).addFile(
          path: result,
          name: '$_fileName.${format.extension}',
          format: format.name,
          templateName: template.name,
          categoryName: template.category,
        );

        setState(() {
          _saveResult = 'File saved successfully!';
        });
        
        logger.log('File save completed successfully');

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('File saved successfully!'),
                Text('Location: $result', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      } else {
        logger.logError('Error saving file: ${result ?? 'Unknown error'}');
        setState(() {
          _saveResult = result ?? 'Error saving file';
        });
      }
    } catch (e, stackTrace) {
      logger.logError('Exception during file save', e, stackTrace);
      setState(() {
        _saveResult = 'Error: $e';
      });
    } finally {
      logger.log('File save process completed');
      setState(() {
        _isSaving = false;
      });
    }
  }
}
