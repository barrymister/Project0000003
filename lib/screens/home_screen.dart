import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/template_provider.dart';
import '../models/template.dart';
import 'template_list_screen.dart';
import 'recent_files_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _showExitConfirmation(BuildContext context) async {
    final bool? shouldExit = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Exit Cosmoscribe?'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Exit'),
              ),
            ],
          ),
    );

    if (shouldExit == true) {
      // Clean up and exit
      // ignore: use_build_context_synchronously
      await SystemNavigator.pop();
    }
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.read<TemplateProvider>().categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cosmoscribe'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _showExitConfirmation(context),
            tooltip: 'Exit App',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(child: _buildCategoryGrid(context, categories)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Scribe your ideas across the cosmos',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.history, color: Colors.white),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecentFilesScreen(),
                      ),
                    ),
                tooltip: 'Recent Files',
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            'Select a category to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, List<String> categories) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.5 : 0.95,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final templates = context
            .read<TemplateProvider>()
            .getTemplatesByCategory(category);
        return _buildCategoryCard(context, category, templates);
      },
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String category,
    List<Template> templates,
  ) {
    // Get image path and color based on category
    String imagePath;
    Color cardColor;

    switch (category) {
      case 'Technical Documents':
        imagePath = 'assets/images/categories/icon_technical.png';
        cardColor = Colors.blue.withOpacity(0.1);
        break;
      case 'Creative Writing':
        imagePath = 'assets/images/categories/icon_creative.png';
        cardColor = Colors.purple.withOpacity(0.1);
        break;
      case 'Academic Writing':
        imagePath = 'assets/images/categories/icon_academic.png';
        cardColor = Colors.amber.withOpacity(0.1);
        break;
      case 'Journalism & Content Creation':
        imagePath = 'assets/images/categories/icon_journalism.png';
        cardColor = Colors.green.withOpacity(0.1);
        break;
      case 'Personal & Miscellaneous':
        imagePath = 'assets/images/categories/icon_personal.png';
        cardColor = Colors.orange.withOpacity(0.1);
        break;
      default:
        imagePath = 'assets/images/logo.png';
        cardColor = Colors.grey.withOpacity(0.1);
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: cardColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplateListScreen(category: category),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 32, height: 32),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${templates.length} templates',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
