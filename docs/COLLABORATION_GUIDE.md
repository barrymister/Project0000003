# Developer-AI Collaboration Guide

This document outlines the roles, responsibilities, and expectations for collaboration between the human developer and AI assistant (Cascade) on the Cosmoscribe project.

## Roles and Responsibilities

### Human Developer Responsibilities

1. **Project Direction and Decision Making**
   - Set overall project goals and priorities
   - Make final decisions on architecture and design choices
   - Approve or modify AI-suggested implementations

2. **Testing and Validation**
   - Test the application on physical devices
   - Validate that implementations work as expected in real-world conditions
   - Identify edge cases that may not be apparent in code review

3. **Android-Specific Tasks**
   - Handle device-specific testing
   - Manage Google Play Store submissions and releases
   - Address hardware-specific issues

4. **External Resources**
   - Provide API keys and credentials when needed
   - Manage access to external services
   - Handle licensing and legal requirements

5. **User Feedback**
   - Collect and interpret user feedback
   - Prioritize feature requests and bug fixes
   - Communicate user needs to the AI assistant

### AI Assistant Responsibilities

1. **Code Implementation**
   - Write clean, maintainable code following Flutter best practices
   - Implement features based on requirements
   - Fix bugs and address technical issues

2. **Documentation**
   - Create and maintain project documentation
   - Document code with appropriate comments
   - Update documentation when implementations change

3. **Problem Analysis**
   - Analyze issues and propose solutions
   - Identify potential edge cases and failure points
   - Suggest improvements to existing code

4. **Knowledge Sharing**
   - Explain technical concepts and implementation details
   - Provide context on Flutter/Dart best practices
   - Share relevant information about libraries and tools

5. **Code Organization**
   - Maintain a consistent project structure
   - Ensure proper separation of concerns
   - Follow established patterns within the codebase

## Collaboration Workflow

1. **Feature Development**
   - Human developer describes feature requirements
   - AI suggests implementation approach
   - Human approves or modifies approach
   - AI implements the feature
   - Human tests and provides feedback
   - AI makes necessary adjustments

2. **Bug Fixing**
   - Human describes bug with reproduction steps
   - AI analyzes the issue and proposes a fix
   - Human approves the approach
   - AI implements the fix
   - Human verifies the fix resolves the issue

3. **Code Refactoring**
   - Either party can identify code that needs improvement
   - AI suggests refactoring approach
   - Human approves the changes
   - AI implements the refactoring
   - Human reviews the changes

## Communication Guidelines

1. **Clear Requirements**
   - Human should provide clear, specific requirements
   - Include acceptance criteria when possible
   - Specify any constraints or limitations

2. **Contextual Information**
   - Human should provide relevant context for tasks
   - Share information about user needs and expectations
   - Explain business logic when necessary

3. **Feedback Loop**
   - Human should provide specific feedback on implementations
   - AI should ask clarifying questions when requirements are unclear
   - Both parties should acknowledge constraints and limitations

## Technical Considerations

1. **Flutter/Dart Version**
   - Project uses latest stable Flutter SDK
   - Code should be compatible with the specified Flutter version
   - Breaking changes in dependencies should be clearly communicated

2. **Testing Limitations**
   - AI cannot directly test on physical devices
   - Human developer is responsible for final validation
   - AI should suggest test cases for the human to verify

3. **Performance Considerations**
   - AI should consider performance implications of implementations
   - Human should test performance on target devices
   - Both should prioritize user experience

## Troubleshooting Process

1. **Issue Identification**
   - Human describes the issue with as much detail as possible
   - Include error messages, logs, and reproduction steps

2. **Diagnostic Approach**
   - AI suggests diagnostic steps or requests specific information
   - Human provides requested information
   - AI analyzes the data to identify root cause

3. **Solution Implementation**
   - AI proposes and implements solution
   - Human tests the solution
   - Both iterate until issue is resolved

## Continuous Improvement

Both the human developer and AI assistant should:
- Reflect on completed work to identify improvement opportunities
- Update this guide as collaboration patterns evolve
- Document lessons learned to improve future collaboration
