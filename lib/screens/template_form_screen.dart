import 'package:flutter/material.dart';
import '../providers/template_provider.dart';
import '../models/template.dart';

import '../providers/format_provider.dart';
import 'format_preview_screen.dart';

class TemplateFormScreen extends StatefulWidget {
  final Template template;

  const TemplateFormScreen({super.key, required this.template});

  @override
  State<TemplateFormScreen> createState() => _TemplateFormScreenState();
}

class _TemplateFormScreenState extends State<TemplateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  late final Template _template;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each field
    _template = widget.template;
    for (var field in _template.fields) {
      _controllers[field.id] = TextEditingController();
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
          Expanded(child: _buildForm(context)),
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
          ..._template.fields.map((field) => _buildFieldInput(context, field)),
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
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 16),
              ),
              const SizedBox(width: 4),
            ],
          ),
          const SizedBox(height: 4),

          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            maxLines:
                field.label.toLowerCase().contains('description') ||
                        field.label.toLowerCase().contains('content')
                    ? 5
                    : 1,
            onChanged: (value) {},
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
      builder:
          (context) => AlertDialog(
            title: Text(_template.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Template Info',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'This template contains ${_template.fields.length} fields.',
                  style: Theme.of(context).textTheme.bodyMedium,
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
