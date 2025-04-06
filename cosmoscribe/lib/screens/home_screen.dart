import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/template_data.dart';
import '../constants/theme_constants.dart';
import '../models/template_model.dart';
import 'template_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = TemplateData.getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cosmoscribe'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: _buildCategoryGrid(context, categories),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scribe your ideas across the cosmos',
            style: AppTheme.headingStyle(context).copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a category to get started',
            style: AppTheme.bodyStyle(context).copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, List<String> categories) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final templates = TemplateData.getTemplatesByCategory(category);
        return _buildCategoryCard(context, category, templates);
      },
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String category, List<Template> templates) {
    // Choose icon based on category
    IconData categoryIcon;
    Color iconColor;

    switch (category) {
      case 'Technical Documents':
        categoryIcon = Icons.description;
        iconColor = Colors.blue;
        break;
      case 'Creative Writing':
        categoryIcon = Icons.create;
        iconColor = Colors.purple;
        break;
      case 'Academic Writing':
        categoryIcon = Icons.school;
        iconColor = Colors.amber;
        break;
      case 'Journalism & Content Creation':
        categoryIcon = Icons.article;
        iconColor = Colors.green;
        break;
      case 'Personal & Miscellaneous':
        categoryIcon = Icons.person;
        iconColor = Colors.orange;
        break;
      default:
        categoryIcon = Icons.folder;
        iconColor = Colors.grey;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplateListScreen(
                category: category,
                templates: templates,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                categoryIcon,
                size: 48,
                color: iconColor,
              ),
              const SizedBox(height: 16),
              Text(
                category,
                style: AppTheme.subheadingStyle(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${templates.length} templates',
                style: AppTheme.captionStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
