import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../constants/theme_constants.dart';
import '../models/format_model.dart';
import '../models/template_model.dart';
import '../providers/app_providers.dart';
import '../services/file_service.dart';
import '../services/formatter_service.dart';
import '../providers/file_history_provider.dart';

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
    
    final formatType = formatProvider.selectedFormatType;
    final format = formatProvider.selectedFormat;
    
    // Generate formatted content
    final formattedContent = FormatterService.formatContent(template, formatType);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview & Save'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFormatSelector(context, formatProvider),
          _buildFileNameInput(context),
          Expanded(
            child: _buildPreview(context, formattedContent, formatType),
          ),
          _buildBottomBar(context, template, formattedContent, format),
        ],
      ),
    );
  }

  Widget _buildFormatSelector(BuildContext context, FormatProvider formatProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Format',
            style: AppTheme.subheadingStyle(context),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: FormatType.values.map((formatType) {
                final format = FileFormat.getFormatByType(formatType);
                final isSelected = formatProvider.selectedFormatType == formatType;
                
                // Format name is sufficient, no need for icons
                
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChoiceChip(
                    label: Text(format.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        formatProvider.selectFormat(formatType);
                      }
                    },

                    backgroundColor: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            FileFormat.getFormatByType(formatProvider.selectedFormatType).description,
            style: AppTheme.captionStyle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFileNameInput(BuildContext context) {
    final saveLocationText = _saveLocation != null
        ? 'File will be saved to: $_saveLocation'
        : 'Preparing save location...';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'File Name',
            style: AppTheme.subheadingStyle(context).copyWith(fontSize: 16),
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
            style: AppTheme.captionStyle(context).copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(BuildContext context, String content, FormatType formatType) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.dividerColor),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              const Icon(
                Icons.preview,
                size: 20,
                color: AppTheme.textSecondaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Preview',
                style: AppTheme.subheadingStyle(context).copyWith(fontSize: 16),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: _buildPreviewContent(context, content, formatType),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewContent(BuildContext context, String content, FormatType formatType) {
    // For Markdown, use the flutter_markdown package
    if (formatType == FormatType.markdown) {
      return Markdown(
        data: content,
        selectable: true,
      );
    }
    
    // For other formats, just show as plain text
    return SingleChildScrollView(
      child: SelectableText(
        content,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    Template template,
    String content,
    FileFormat format,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
                  color: _saveResult!.startsWith('Error')
                      ? AppTheme.errorColor
                      : Colors.green,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _isSaving
                      ? null
                      : () => _saveFile(context, content, format),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSaving
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
    FileFormat format,
  ) async {
    if (_fileName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a file name')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
      _saveResult = null;
    });

    final result = await FileService.saveFile(
      content,
      _fileName,
      format.extension,
    );

    setState(() {
      _isSaving = false;
      _saveResult = result;
    });

    if (result != null && !result.startsWith('Error') && !result.contains('denied')) {
      // Add to file history
      // ignore: use_build_context_synchronously
      Provider.of<FileHistoryProvider>(context, listen: false).addFile(
        path: result,
        name: _fileName + format.extension,
        format: format.name,
        templateName: template.name,
        categoryName: template.category,
      );

      // Show success message with file path
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('File saved successfully!'),
              Text(
                'Location: $result',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      // Show error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ?? 'Error saving file')),
      );
    }
  }
}
