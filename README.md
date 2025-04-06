# Cosmoscribe

Cosmoscribe is an Android application developed using Flutter that empowers users to organize and save their brainstorming ideas across the cosmos. It transforms a single thought into a multitude of structured outputs through categorized templates.

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

<<<<<<< HEAD
- Flutter SDK
=======
- Flutter SDK (latest stable version)
>>>>>>> 7743d8c4c1d50dbf111cf3c07362fee022697e60
- Android Studio or VS Code with Flutter extensions
- Android device or emulator

### Installation

<<<<<<< HEAD
1. Clone the repository
=======
1. Clone this repository:
>>>>>>> 7743d8c4c1d50dbf111cf3c07362fee022697e60
   ```
   git clone https://github.com/barrymister/Project0000003.git
   ```

<<<<<<< HEAD
2. Navigate to the project directory
   ```
   cd Project0000003/temp/cosmoscribe
   ```

3. Install dependencies
=======
2. Navigate to the project directory:
   ```
   cd Project0000003/cosmoscribe
   ```

3. Get dependencies:
>>>>>>> 7743d8c4c1d50dbf111cf3c07362fee022697e60
   ```
   flutter pub get
   ```

<<<<<<< HEAD
4. Run the app
=======
4. Run the app:
>>>>>>> 7743d8c4c1d50dbf111cf3c07362fee022697e60
   ```
   flutter run
   ```

<<<<<<< HEAD
## Project Structure

- `lib/models/`: Data models for templates and formats
- `lib/screens/`: UI screens for the app
- `lib/services/`: Services for formatting and file operations
- `lib/widgets/`: Reusable UI components
- `lib/constants/`: App constants and theme definitions
- `lib/providers/`: State management using Provider

## Dependencies

- Provider: State management
- File Picker: For selecting files to save
- Path Provider: To find the correct file paths
- Permission Handler: To manage permissions for file access
- Flutter Markdown: For rendering markdown previews
- Google Fonts: For custom typography
=======
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

## License

This project is proprietary and not licensed for redistribution.

## Acknowledgments

- Developed for Barry Mister
- Created with Flutter and Dart
>>>>>>> 7743d8c4c1d50dbf111cf3c07362fee022697e60
