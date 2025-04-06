import 'package:flutter/foundation.dart';
import '../models/template.dart';

// Define template categories and their templates
const Map<String, List<Template>> _templateCategories = {
  'Technical Documents': [
    Template(
      name: 'Product Requirements Document',
      category: 'Technical Documents',
      fields: [
        'Product Name',
        'Purpose',
        'Target Users',
        'Key Features',
        'Technical Requirements',
        'Constraints',
        'Success Criteria'
      ],
    ),
    Template(
      name: 'Technical Specification',
      category: 'Technical Documents',
      fields: [
        'System Overview',
        'Architecture',
        'Components',
        'Interfaces',
        'Data Flow',
        'Performance Requirements'
      ],
    ),
    Template(
      name: 'Meeting Notes',
      category: 'Technical Documents',
      fields: [
        'Date',
        'Attendees',
        'Agenda',
        'Discussions',
        'Decisions',
        'Action Items'
      ],
    ),
  ],
  'Creative Writing': [
    Template(
      name: 'Short Story Outline',
      category: 'Creative Writing',
      fields: [
        'Title',
        'Setting',
        'Characters',
        'Plot',
        'Themes',
        'Resolution'
      ],
    ),
    Template(
      name: 'Poetry',
      category: 'Creative Writing',
      fields: [
        'Title',
        'Theme',
        'Style',
        'Stanzas',
        'Rhyme Scheme',
        'Tone'
      ],
    ),
    Template(
      name: 'Novel Chapter',
      category: 'Creative Writing',
      fields: [
        'Chapter Title',
        'Chapter Number',
        'Characters',
        'Setting',
        'Plot Points',
        'Conflict',
        'Resolution'
      ],
    ),
  ],
  'Academic Writing': [
    Template(
      name: 'Essay',
      category: 'Academic Writing',
      fields: [
        'Title',
        'Thesis Statement',
        'Introduction',
        'Main Arguments',
        'Evidence',
        'Counterarguments',
        'Conclusion'
      ],
    ),
    Template(
      name: 'Research Notes',
      category: 'Academic Writing',
      fields: [
        'Research Question',
        'Sources',
        'Key Findings',
        'Analysis',
        'Implications',
        'Further Research'
      ],
    ),
    Template(
      name: 'Study Guide',
      category: 'Academic Writing',
      fields: [
        'Subject',
        'Topics',
        'Key Concepts',
        'Important Dates',
        'Practice Questions',
        'Resources'
      ],
    ),
  ],
  'Journalism & Content Creation': [
    Template(
      name: 'Blog Post',
      category: 'Journalism & Content Creation',
      fields: [
        'Title',
        'Introduction',
        'Main Points',
        'Evidence',
        'Conclusion',
        'Call to Action'
      ],
    ),
    Template(
      name: 'News Article',
      category: 'Journalism & Content Creation',
      fields: [
        'Headline',
        'Byline',
        'Date',
        'Location',
        'Lead',
        'Body',
        'Quotes',
        'Sources'
      ],
    ),
    Template(
      name: 'Content Outline',
      category: 'Journalism & Content Creation',
      fields: [
        'Topic',
        'Purpose',
        'Target Audience',
        'Key Sections',
        'Visual Elements',
        'Call to Action'
      ],
    ),
  ],
  'Personal & Miscellaneous': [
    Template(
      name: 'Personal Journal',
      category: 'Personal & Miscellaneous',
      fields: [
        'Date',
        'Location',
        'Mood',
        'Events',
        'Feelings',
        'Reflections'
      ],
    ),
    Template(
      name: 'To-Do List',
      category: 'Personal & Miscellaneous',
      fields: [
        'Date',
        'Tasks',
        'Priorities',
        'Notes',
        'Status'
      ],
    ),
    Template(
      name: 'Idea Bank',
      category: 'Personal & Miscellaneous',
      fields: [
        'Idea Title',
        'Description',
        'Context',
        'Potential Uses',
        'Next Steps'
      ],
    ),
  ],
};

class TemplateProvider with ChangeNotifier {
  final Map<String, List<Template>> _templateCategories = _templateCategories;

  List<String> get categories => _templateCategories.keys.toList();

  List<Template> getTemplatesByCategory(String category) {
    return _templateCategories[category] ?? [];
  }

  Template? _selectedTemplate;
  Template? get selectedTemplate => _selectedTemplate;

  void selectTemplate(Template template) {
    _selectedTemplate = template;
    notifyListeners();
  }
}
