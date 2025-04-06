# Cosmoscribe Test Plan

## Overview
This document outlines the testing strategy for Cosmoscribe to ensure quality and stability.

## Test Types

### Unit Tests
- Template and format models
- Formatter service logic
- File service methods

### Widget Tests
- Template form UI
- Format selection UI
- Preview screen rendering

### Integration Tests
- Saving files
- Opening recent files
- Format export workflows

### Manual Testing
- On various Android devices and emulators
- Permissions handling
- File browsing and saving
- UI responsiveness

## Tools
- `flutter test`
- Android emulators
- Physical devices

## Test Data
- Sample templates with various fields
- Different export formats
- Edge cases (empty fields, large content)

## Acceptance Criteria
- No critical or high severity bugs
- All core workflows function as expected
- UI is responsive and accessible