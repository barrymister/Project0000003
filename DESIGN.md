# Cosmoscribe Design Document

## Architecture Overview

### State Management
- Using Provider pattern for app-wide state management
- Key providers:
  - TemplateProvider: Manages selected template and its fields
  - FormatProvider: Manages output format selection

### Project Structure
```
lib/
├── constants/      # App-wide constants, themes, and template data
├── models/         # Data models for templates and formats
├── providers/      # State management
├── screens/        # UI screens
├── services/       # Business logic and utilities
└── widgets/        # Reusable UI components
```

## Design Decisions

### UI/UX
1. **Category Grid Layout**
   - Two-column grid for efficient space usage
   - Responsive design that adapts to different screen sizes
   - Custom icons for visual recognition
   - Color-coded categories for better navigation

2. **Format Selection**
   - Horizontal scrolling chip list for format selection
   - Simple text-based chips (removed icons for cleaner UI)
   - Format description displayed below selection

3. **Preview Screen**
   - Split view with input form and preview
   - Real-time preview updates
   - Syntax highlighting for code blocks

### File Management
- Using path_provider for standard Android storage locations
- Removed file_picker dependency for simpler implementation
- Implemented direct file saving with proper Android permissions

## Planned Features & Improvements

### Priority Improvements
1. [ ] Add proper file management:
   - Show current save location
   - File history/recent files list
   - Ability to browse and open previously saved files
   - Clear indication of save status and location
2. [ ] Improve app navigation:
   - Add exit button in intuitive location (e.g., app bar menu)
   - Confirm exit if there are unsaved changes
   - Better back navigation handling

### Short Term
1. [ ] Add search functionality for templates
2. [ ] Implement template favorites
3. [ ] Add dark mode support
4. [ ] Improve tablet layout optimization

### Medium Term
1. [ ] Template customization
2. [ ] Cloud backup integration
3. [ ] Export to additional formats
4. [ ] Template sharing between users

### Long Term
1. [ ] Collaborative editing features
2. [ ] AI-assisted template suggestions
3. [ ] Integration with popular note-taking apps
4. [ ] Desktop version support

## Testing Strategy
- Unit tests for formatter service
- Widget tests for UI components
- Integration tests for file operations
- Manual testing on various Android devices:
  - Small phones (5" screens)
  - Medium phones (6" screens)
  - Large phones (6.5"+ screens)
  - Tablets (7"+ screens)
  - Foldables

## Revenue Strategy

### Direct Sale ($3.99)
- Target audience: Professional users
- All features unlocked
- Priority support
- Early access to new templates

### Freemium ($1.99 IAP)
- Basic features free
- Limited template selection
- Markdown-only export
- IAP to unlock all features

## Known Issues & Technical Debt
1. No file history or management system
2. Missing intuitive app exit functionality
3. Unclear file save locations and status
4. Permission handling needs improvement
5. Build process occasionally has file locking issues
6. Layout adjustments needed for very small screens
7. Memory optimization for large documents

## Future Considerations
1. iOS version feasibility
2. Web version potential
3. Integration with version control systems
4. Template marketplace concept

## Design Resources
- Color palette
- Typography system
- Icon set guidelines
- UI component library

## Development Guidelines
1. Code style and formatting
2. Git workflow
3. Testing requirements
4. Documentation standards

_This is a living document that will be updated as the project evolves._
