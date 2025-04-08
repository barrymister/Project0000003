# Contributing to Cosmoscribe

Thank you for your interest in contributing to Cosmoscribe! This document provides guidelines and instructions for contributing to the project.

## Development Setup

### Prerequisites
- Flutter SDK (2.5.0 or higher)
- Android Studio or VS Code with Flutter extensions
- Git

### Getting Started
1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/Project0000003.git
   cd Project0000003
   ```
3. Add the original repository as upstream:
   ```bash
   git remote add upstream https://github.com/barrymister/Project0000003.git
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```

## Code Style and Guidelines

### Flutter/Dart Style
- Follow the [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use the standard Flutter architecture patterns
- Run `flutter format .` before submitting changes

### Code Organization
- Place models in `lib/models/`
- Place providers in `lib/providers/`
- Place screens in `lib/screens/`
- Place services in `lib/services/`
- Place widgets in `lib/widgets/`
- Place constants in `lib/constants/`

### Documentation
- Add documentation comments to all public APIs
- Update README.md if you're changing user-facing features
- Update DESIGN.md if you're changing architecture

## Pull Request Process

1. Create a new branch for your feature or bugfix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit them with clear, descriptive messages:
   ```bash
   git commit -m "Add feature: description of your changes"
   ```

3. Push your branch to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

4. Submit a pull request to the main repository

5. Update your pull request based on feedback

## Adding New Templates

When adding new templates:

1. Add the template to `lib/constants/template_data.dart`
2. Follow the existing template structure
3. Ensure all fields have clear labels and hints
4. Add the template to the appropriate category
5. Update README.md to include the new template in the list

## Adding New Formats

When adding new output formats:

1. Add the format to `lib/models/format.dart` in the `allFormats` list
2. Implement the formatter in `lib/services/formatter_service.dart`
3. Test the format with various templates
4. Update README.md to include the new format

## Testing

- Write tests for new features
- Run existing tests before submitting changes:
  ```bash
  flutter test
  ```

## License

By contributing to Cosmoscribe, you agree that your contributions will be licensed under the project's license.
