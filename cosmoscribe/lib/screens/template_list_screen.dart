import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/theme_constants.dart';
import '../models/template_model.dart';
import 'template_form_screen.dart';

class TemplateListScreen extends StatelessWidget {
  final String category;
  final List<Template> templates;

  const TemplateListScreen({
    super.key,
    required this.category,
    required this.templates,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: _buildTemplateList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select a Template',
            style: AppTheme.subheadingStyle(context),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose a template to start scribing your ideas',
            style: AppTheme.captionStyle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return _buildTemplateCard(context, template);
      },
    );
  }

  Widget _buildTemplateCard(BuildContext context, Template template) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          final templateProvider = Provider.of<TemplateProvider>(
            context,
            listen: false,
          );
          templateProvider.selectTemplate(template);
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplateFormScreen(template: template),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                template.name,
                style: AppTheme.subheadingStyle(context),
              ),
              const SizedBox(height: 8),
              Text(
                template.description,
                style: AppTheme.bodyStyle(context),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppTheme.textSecondaryColor,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Use Case: ${template.useCase}',
                      style: AppTheme.captionStyle(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.format_list_bulleted,
                    size: 16,
                    color: AppTheme.textSecondaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${template.fields.length} fields',
                    style: AppTheme.captionStyle(context),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
