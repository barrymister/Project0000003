# Cosmoscribe

A Flutter app for Android that allows users to organize and save their brainstorming ideas using categorized templates.

## Features

- **Template Selection**: Browse and select from 15+ templates across five categories:
  - Technical Documents
  - Creative Writing
  - Academic Writing
  - Journalism & Content Creation
  - Personal & Miscellaneous

- **Input Forms**: Each template has predefined fields tailored to its purpose

- **Format Selection**: Choose from multiple output formats:
  - Markdown
  - Plain Text
  - YAML
  - reStructuredText
  - AsciiDoc

- **Preview and Save**: Preview your content in real-time and save it to your device

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio or VS Code with Flutter extensions
- Android device or emulator

### Installation

1. Clone the repository
   ```
   git clone https://github.com/barrymister/Project0000003.git
   ```

2. Navigate to the project directory
   ```
   cd Project0000003/temp/cosmoscribe
   ```

3. Install dependencies
   ```
   flutter pub get
   ```

4. Run the app
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
- File Picker: For selecting files to save
- Path Provider: To find the correct file paths
- Permission Handler: To manage permissions for file access
- Flutter Markdown: For rendering markdown previews
- Google Fonts: For custom typography
