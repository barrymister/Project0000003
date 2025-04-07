# Cosmoscribe

<img src="assets/images/logo.png" alt="Cosmoscribe Logo" width="200"/>

Cosmoscribe is an Android application developed using Flutter that empowers users to organize and save their brainstorming ideas across the cosmos. It transforms a single thought into a multitude of structured outputs through categorized templates.

## Getting Started

### Prerequisites
- Flutter SDK (2.5.0 or higher)
- Android Studio or VS Code with Flutter extensions
- Android device or emulator (API level 21+)

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/barrymister/Project0000003.git
   cd Project0000003
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Connect an Android device or start an emulator.**

4. **Run the app:**
   ```bash
   flutter run
   ```

5. **Select a template, fill in the fields, choose an export format, and save your document.**

## Screenshots

<!-- Add screenshots here once the app is complete -->

## Features

- **Template Selection**: Browse and select from 15+ templates across 5 categories:
  - Technical Documents
  - Creative Writing
  - Academic Writing
  - Journalism & Content Creation
  - Personal & Miscellaneous

- **Input Forms**: Each template provides predefined fields tailored to its purpose

- **Format Selection**: Choose from multiple output formats:
  - Markdown (.md): Widely portable and readable in text editors or platforms like GitHub
  - Plain Text (.txt): Simplest output, universally compatible, no formatting overhead
  - YAML (.yaml): Structured data format, ideal for tech users or parsing into other systems
  - reStructuredText (.rst): Richer formatting for technical documentation, convertible to HTML/PDF
  - AsciiDoc (.adoc): Detailed, flexible output for writing or tech docs, supported by tools like Asciidoctor

- **Preview and Save**: Preview your content in real-time and save it to your device

When saving a document, you can **choose from these formats** to export your content. The app provides a format selection interface during the save process, allowing you to pick the most suitable output format for your needs.

## Categories and Templates

1. **Technical Documents**
   - Product Requirements Document (PRD)
   - Technical Specification (Tech Spec)
   - Meeting Notes

2. **Creative Writing**
   - Short Story Outline
   - Poetry
   - Novel Chapter

3. **Academic Writing**
   - Essay
   - Research Notes
   - Study Guide

4. **Journalism & Content Creation**
   - Blog Post
   - Interview Notes
   - Review

5. **Personal & Miscellaneous**
   - Journal Entry
   - Idea Dump
   - Travel Plan

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio or VS Code with Flutter extensions
- Android device or emulator

### Installation

1. Clone this repository:
   ```
   git clone https://github.com/barrymister/Project0000003.git
   ```

2. Navigate to the project directory:
   ```
   cd Project0000003/temp/cosmoscribe
   ```

3. Get dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Project Structure

- `lib/models/`: Data models for templates and formats
- `lib/screens/`: UI screens for the app
- `lib/services/`: Services for formatting and file operations
- `lib/widgets/`: Reusable UI components
- `lib/constants/`: App constants and theme definitions
- `lib/providers/`: State management using Provider

## Dependencies

- Provider: State management
- Path Provider: To find the correct file paths
- Permission Handler: To manage permissions for file access
- Flutter Markdown: For rendering markdown previews
- Google Fonts: For custom typography

## Building for Release

To build a release APK:

```
flutter build apk
```

To build an app bundle for Play Store submission:

```
flutter build appbundle
```

## Revenue Model

- **Direct Sale**: $3.99 for the full Cosmoscribe experience, including all templates and file formats.
- **Freemium Option**: Free version with Markdown output and 5 basic templates, $1.99 in-app purchase to unlock all categories, templates, and formats.

## Troubleshooting

### Common Issues

#### App crashes when saving files
- Ensure storage permissions are granted in Android settings
- Check that the destination folder exists and is writable
- Verify there's enough storage space on the device

#### Templates not loading
- Restart the app to refresh the template cache
- Check your internet connection if templates are loaded remotely
- Clear app cache in Android settings

#### Preview not displaying correctly
- Some format previews may not render all features in the app
- Try a different format if specific formatting isn't displaying properly
- For complex documents, save the file and open in a dedicated viewer

### Getting Help

If you encounter any issues not covered here, please:
1. Check the [Issues](https://github.com/barrymister/Project0000003/issues) page on GitHub
2. Submit a new issue with detailed reproduction steps
3. Include your device model and Android version

## License

This project is proprietary and not licensed for redistribution.

## Acknowledgments

- Developed for Barry Mister
- Created with Flutter and Dart

## FAQ

### How do I select a file format when saving?

After filling out your template, tap **Save to Device**. You will be prompted to select from supported formats like Markdown, Plain Text, YAML, reStructuredText, or AsciiDoc.

### Where are my saved files located?

By default, files are saved in the **Cosmoscribe** folder inside your device's documents directory. You can view the save location before saving.

### Can I add my own templates?

Currently, templates are predefined. Future updates may support custom templates.

### Why can't I open recent files?

Ensure the file still exists on your device and that storage permissions are granted. Some emulators reset storage between sessions.

### Does Cosmoscribe work offline?

Yes, all features work without an internet connection.

