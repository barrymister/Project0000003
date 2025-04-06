import '../models/template.dart';

/// Centralized storage for all template data
class TemplateData {
  /// All available templates in the application
  static final List<Template> allTemplates = [
    // Technical Documents
    Template(
      id: 'prd',
      name: 'Product Requirements Document (PRD)',
      category: 'Technical Documents',
      subcategory: 'Product Documentation',
      description: 'Define product requirements and specifications',
      useCase: 'Plan a product or app, defining its purpose and requirements.',
      fields: [
        TemplateField(
          id: 'overview',
          label: 'Overview',
          hint: 'Provide a brief description of the product',
          isRequired: true,
        ),
        TemplateField(
          id: 'goals',
          label: 'Goals',
          hint: 'List the main goals of the product',
          isRequired: true,
        ),
        TemplateField(
          id: 'features',
          label: 'Features',
          hint: 'Describe the key features of the product',
          isRequired: true,
        ),
        TemplateField(
          id: 'user_stories',
          label: 'User Stories',
          hint: 'Describe how users will interact with the product',
          isRequired: false,
        ),
        TemplateField(
          id: 'success_metrics',
          label: 'Success Metrics',
          hint: 'Define how success will be measured',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'tech_spec',
      name: 'Technical Specification (Tech Spec)',
      category: 'Technical Documents',
      subcategory: 'Product Documentation',
      description: 'Detail the technical design of a system or component',
      useCase: 'Detail the technical design of a system or component.',
      fields: [
        TemplateField(
          id: 'objective',
          label: 'Objective',
          hint: 'State the purpose of this technical specification',
          isRequired: true,
        ),
        TemplateField(
          id: 'architecture',
          label: 'Architecture',
          hint: 'Describe the system architecture',
          isRequired: true,
        ),
        TemplateField(
          id: 'apis',
          label: 'APIs',
          hint: 'Document the APIs used or created',
          isRequired: false,
        ),
        TemplateField(
          id: 'dependencies',
          label: 'Dependencies',
          hint: 'List all dependencies',
          isRequired: false,
        ),
        TemplateField(
          id: 'risks',
          label: 'Risks',
          hint: 'Identify potential risks and mitigations',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'meeting_notes',
      name: 'Meeting Notes',
      category: 'Technical Documents',
      subcategory: 'Collaboration',
      description: 'Capture key points from meetings',
      useCase: 'Summarize key points and outcomes from meetings.',
      fields: [
        TemplateField(
          id: 'attendees',
          label: 'Attendees',
          hint: 'List all meeting participants',
          isRequired: true,
        ),
        TemplateField(
          id: 'agenda',
          label: 'Agenda',
          hint: 'Outline the meeting agenda',
          isRequired: true,
        ),
        TemplateField(
          id: 'discussion',
          label: 'Discussion',
          hint: 'Summarize the main discussion points',
          isRequired: true,
        ),
        TemplateField(
          id: 'action_items',
          label: 'Action Items',
          hint: 'List action items and who is responsible',
          isRequired: false,
        ),
      ],
    ),

    // Creative Writing
    Template(
      id: 'short_story',
      name: 'Short Story Outline',
      category: 'Creative Writing',
      subcategory: 'Fiction',
      description: 'Outline a short story',
      useCase: 'Sketch the framework of a concise narrative.',
      fields: [
        TemplateField(
          id: 'title',
          label: 'Title',
          hint: 'Give your story a title',
          isRequired: true,
        ),
        TemplateField(
          id: 'characters',
          label: 'Characters',
          hint: 'Describe the main characters',
          isRequired: true,
        ),
        TemplateField(
          id: 'setting',
          label: 'Setting',
          hint: 'Describe when and where the story takes place',
          isRequired: true,
        ),
        TemplateField(
          id: 'plot_points',
          label: 'Plot Points',
          hint: 'List the main events in the story',
          isRequired: true,
        ),
        TemplateField(
          id: 'twist',
          label: 'Twist',
          hint: 'Describe any unexpected turns in the story',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'poetry',
      name: 'Poetry',
      category: 'Creative Writing',
      subcategory: 'Poetry',
      description: 'Draft a poem with structured inspiration prompts',
      useCase: 'Draft a poem with structured inspiration prompts.',
      fields: [
        TemplateField(
          id: 'theme',
          label: 'Theme',
          hint: 'What is the poem about?',
          isRequired: true,
        ),
        TemplateField(
          id: 'mood',
          label: 'Mood',
          hint: 'What feeling do you want to convey?',
          isRequired: true,
        ),
        TemplateField(
          id: 'lines',
          label: 'Lines',
          hint: 'Write the lines of your poem',
          isRequired: true,
        ),
        TemplateField(
          id: 'imagery',
          label: 'Imagery',
          hint: 'Describe the visual elements in your poem',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'novel_chapter',
      name: 'Novel Chapter',
      category: 'Creative Writing',
      subcategory: 'Fiction',
      description: 'Plan a single chapter of a larger story',
      useCase: 'Plan a single chapter of a larger story.',
      fields: [
        TemplateField(
          id: 'chapter_goal',
          label: 'Chapter Goal',
          hint: 'What should this chapter accomplish?',
          isRequired: true,
        ),
        TemplateField(
          id: 'characters',
          label: 'Characters',
          hint: 'Which characters appear in this chapter?',
          isRequired: true,
        ),
        TemplateField(
          id: 'conflict',
          label: 'Conflict',
          hint: 'What challenges do the characters face?',
          isRequired: true,
        ),
        TemplateField(
          id: 'resolution',
          label: 'Resolution',
          hint: 'How does the chapter end?',
          isRequired: false,
        ),
      ],
    ),

    // Academic Writing
    Template(
      id: 'essay',
      name: 'Essay',
      category: 'Academic Writing',
      subcategory: 'Essays',
      description: 'Structure a persuasive or analytical essay',
      useCase: 'Structure a persuasive or analytical essay.',
      fields: [
        TemplateField(
          id: 'thesis',
          label: 'Thesis',
          hint: 'State your main argument',
          isRequired: true,
        ),
        TemplateField(
          id: 'introduction',
          label: 'Introduction',
          hint: 'Introduce your topic and thesis',
          isRequired: true,
        ),
        TemplateField(
          id: 'arguments',
          label: 'Arguments',
          hint: 'Present your supporting arguments',
          isRequired: true,
        ),
        TemplateField(
          id: 'counterpoints',
          label: 'Counterpoints',
          hint: 'Address opposing viewpoints',
          isRequired: false,
        ),
        TemplateField(
          id: 'conclusion',
          label: 'Conclusion',
          hint: 'Summarize your arguments and restate your thesis',
          isRequired: true,
        ),
      ],
    ),
    Template(
      id: 'research_notes',
      name: 'Research Notes',
      category: 'Academic Writing',
      subcategory: 'Research',
      description: 'Organize research for papers or projects',
      useCase: 'Organize research for papers or projects.',
      fields: [
        TemplateField(
          id: 'topic',
          label: 'Topic',
          hint: 'Define your research topic',
          isRequired: true,
        ),
        TemplateField(
          id: 'sources',
          label: 'Sources',
          hint: 'List your research sources',
          isRequired: true,
        ),
        TemplateField(
          id: 'key_findings',
          label: 'Key Findings',
          hint: 'Summarize your main discoveries',
          isRequired: true,
        ),
        TemplateField(
          id: 'gaps',
          label: 'Gaps',
          hint: 'Identify areas needing more research',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'study_guide',
      name: 'Study Guide',
      category: 'Academic Writing',
      subcategory: 'Education',
      description: 'Create a tool for studying or teaching',
      useCase: 'Create a tool for studying or teaching.',
      fields: [
        TemplateField(
          id: 'topic',
          label: 'Topic',
          hint: 'What subject is this study guide for?',
          isRequired: true,
        ),
        TemplateField(
          id: 'definitions',
          label: 'Definitions',
          hint: 'List key terms and their definitions',
          isRequired: true,
        ),
        TemplateField(
          id: 'examples',
          label: 'Examples',
          hint: 'Provide examples that illustrate key concepts',
          isRequired: true,
        ),
        TemplateField(
          id: 'practice_questions',
          label: 'Practice Questions',
          hint: 'Include questions for self-assessment',
          isRequired: false,
        ),
      ],
    ),

    // Journalism & Content Creation
    Template(
      id: 'blog_post',
      name: 'Blog Post',
      category: 'Journalism & Content Creation',
      subcategory: 'Digital Content',
      description: 'Plan a blog article with a clear structure',
      useCase: 'Plan a blog article with a clear structure.',
      fields: [
        TemplateField(
          id: 'title',
          label: 'Title',
          hint: 'Create an engaging title for your post',
          isRequired: true,
        ),
        TemplateField(
          id: 'hook',
          label: 'Hook',
          hint: 'Write an attention-grabbing opening',
          isRequired: true,
        ),
        TemplateField(
          id: 'sections',
          label: 'Sections',
          hint: 'Outline the main sections of your post',
          isRequired: true,
        ),
        TemplateField(
          id: 'call_to_action',
          label: 'Call to Action',
          hint: 'What do you want readers to do after reading?',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'interview_notes',
      name: 'Interview Notes',
      category: 'Journalism & Content Creation',
      subcategory: 'Interviews',
      description: 'Record and organize interview content',
      useCase: 'Record and organize interview content.',
      fields: [
        TemplateField(
          id: 'subject',
          label: 'Subject',
          hint: 'Who is being interviewed?',
          isRequired: true,
        ),
        TemplateField(
          id: 'questions',
          label: 'Questions',
          hint: 'List the questions asked',
          isRequired: true,
        ),
        TemplateField(
          id: 'answers',
          label: 'Answers',
          hint: 'Record the subject\'s responses',
          isRequired: true,
        ),
        TemplateField(
          id: 'key_quotes',
          label: 'Key Quotes',
          hint: 'Highlight notable quotes from the interview',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'review',
      name: 'Review',
      category: 'Journalism & Content Creation',
      subcategory: 'Reviews',
      description: 'Critique a product, service, or media',
      useCase: 'Critique a product, service, or media.',
      fields: [
        TemplateField(
          id: 'item',
          label: 'Item',
          hint: 'What are you reviewing?',
          isRequired: true,
        ),
        TemplateField(
          id: 'pros',
          label: 'Pros',
          hint: 'List the positive aspects',
          isRequired: true,
        ),
        TemplateField(
          id: 'cons',
          label: 'Cons',
          hint: 'List the negative aspects',
          isRequired: true,
        ),
        TemplateField(
          id: 'rating',
          label: 'Rating',
          hint: 'Provide a numerical or star rating',
          isRequired: true,
        ),
        TemplateField(
          id: 'verdict',
          label: 'Verdict',
          hint: 'Summarize your overall assessment',
          isRequired: true,
        ),
      ],
    ),

    // Personal & Miscellaneous
    Template(
      id: 'journal_entry',
      name: 'Journal Entry',
      category: 'Personal & Miscellaneous',
      subcategory: 'Personal',
      description: 'Log daily thoughts or experiences',
      useCase: 'Log daily thoughts or experiences.',
      fields: [
        TemplateField(
          id: 'date',
          label: 'Date',
          hint: 'When was this entry written?',
          isRequired: true,
        ),
        TemplateField(
          id: 'mood',
          label: 'Mood',
          hint: 'How are you feeling?',
          isRequired: false,
        ),
        TemplateField(
          id: 'events',
          label: 'Events',
          hint: 'What happened today?',
          isRequired: true,
        ),
        TemplateField(
          id: 'reflection',
          label: 'Reflection',
          hint: 'Your thoughts about these events',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'idea_dump',
      name: 'Idea Dump',
      category: 'Personal & Miscellaneous',
      subcategory: 'Brainstorming',
      description: 'Capture random ideas for later development',
      useCase: 'Capture random ideas for later development.',
      fields: [
        TemplateField(
          id: 'concept',
          label: 'Concept',
          hint: 'Describe your idea briefly',
          isRequired: true,
        ),
        TemplateField(
          id: 'details',
          label: 'Details',
          hint: 'Elaborate on the idea',
          isRequired: false,
        ),
        TemplateField(
          id: 'next_steps',
          label: 'Next Steps',
          hint: 'What should you do to develop this idea?',
          isRequired: false,
        ),
      ],
    ),
    Template(
      id: 'travel_plan',
      name: 'Travel Plan',
      category: 'Personal & Miscellaneous',
      subcategory: 'Travel',
      description: 'Outline a trip or adventure',
      useCase: 'Outline a trip or adventure.',
      fields: [
        TemplateField(
          id: 'destination',
          label: 'Destination',
          hint: 'Where are you going?',
          isRequired: true,
        ),
        TemplateField(
          id: 'dates',
          label: 'Dates',
          hint: 'When is your trip?',
          isRequired: true,
        ),
        TemplateField(
          id: 'activities',
          label: 'Activities',
          hint: 'What do you plan to do?',
          isRequired: true,
        ),
        TemplateField(
          id: 'notes',
          label: 'Notes',
          hint: 'Any additional information',
          isRequired: false,
        ),
      ],
    ),
  ];

  static List<String> getCategories() {
    final categories = allTemplates.map((template) => template.category).toSet().toList();
    categories.sort();
    return categories;
  }

  static List<Template> getTemplatesByCategory(String category) {
    return allTemplates.where((template) => template.category == category).toList();
  }

  static Template getTemplateById(String id) {
    return allTemplates.firstWhere((template) => template.id == id);
  }
}
