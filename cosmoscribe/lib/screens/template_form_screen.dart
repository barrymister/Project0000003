import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/theme_constants.dart';
import '../models/template_model.dart';
import 'format_preview_screen.dart';

class TemplateFormScreen extends StatefulWidget {
  final Template template;

  const TemplateFormScreen({
    super.key,
    required this.template,
  });

  @override
  State<TemplateFormScreen> createState() => _TemplateFormScreenState();
}

class _TemplateFormScreenState extends State<TemplateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each field
    for (var field in widget.template.fields) {
      _controllers[field.id] = TextEditingController(text: field.value);
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.template.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _showTemplateInfo(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildForm(context),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...widget.template.fields.map((field) => _buildFieldInput(context, field)),
        ],
      ),
    );
  }

  Widget _buildFieldInput(BuildContext context, TemplateField field) {
    final controller = _controllers[field.id]!;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                field.label,
                style: AppTheme.subheadingStyle(context).copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
              if (field.isRequired)
                const Text(
                  '*',
                  style: TextStyle(
                    color: AppTheme.errorColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            field.hint,
            style: AppTheme.captionStyle(context),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            maxLines: field.id.contains('description') || 
                      field.id.contains('content') || 
                      field.id.contains('lines') ? 
                      5 : 1,
            validator: (value) {
              if (field.isRequired && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
            onChanged: (value) {
              // Update the template field value
              final templateProvider = Provider.of<TemplateProvider>(
                context, 
                listen: false,
              );
              templateProvider.updateTemplateField(field.id, value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
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
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save form data to template provider
                  for (var field in widget.template.fields) {
                    final controller = _controllers[field.id]!;
                    final templateProvider = Provider.of<TemplateProvider>(
                      context, 
                      listen: false,
                    );
                    templateProvider.updateTemplateField(field.id, controller.text);
                  }
                  
                  // Navigate to format preview screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormatPreviewScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Preview & Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _showTemplateInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.template.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: AppTheme.subheadingStyle(context).copyWith(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              widget.template.description,
              style: AppTheme.bodyStyle(context),
            ),
            const SizedBox(height: 16),
            Text(
              'Use Case',
              style: AppTheme.subheadingStyle(context).copyWith(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              widget.template.useCase,
              style: AppTheme.bodyStyle(context),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
