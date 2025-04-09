# Architecture Decision Records (ADR) - Cosmoscribe

## ADR-001: Use Flutter with Provider
- **Date:** 2025-04-06
- **Decision:** Use Flutter framework with Provider for state management.
- **Rationale:** Cross-platform support, fast development, community support.
- **Consequences:** Easier UI development, scalable state management.

## ADR-002: Local File Storage
- **Date:** 2025-04-06
- **Decision:** Store files locally on device using path_provider.
- **Rationale:** Offline access, user privacy.
- **Consequences:** Need to handle permissions and storage management.

## ADR-003: Support Multiple Export Formats
- **Date:** 2025-04-06
- **Decision:** Support Markdown, Plain Text, YAML, reStructuredText, AsciiDoc.
- **Rationale:** Flexibility for different user needs.
- **Consequences:** Need to maintain formatters and previews.

## ADR-004: Remove Nested Flutter Module
- **Date:** 2025-04-06
- **Decision:** Consolidate project into a single Flutter app.
- **Rationale:** Simplify build and maintenance.
- **Consequences:** Easier development, less complexity.

## ADR-005: Implement Comprehensive Logging System
- **Date:** 2025-04-08
- **Decision:** Create a dedicated LoggerService for application-wide logging.
- **Rationale:** Improve debugging capabilities, track user actions and system events, facilitate error reporting.
- **Consequences:** Better troubleshooting, increased ability to diagnose issues in production, slight performance overhead.

## ADR-006: Enhanced Error Handling for File Operations
- **Date:** 2025-04-08
- **Decision:** Implement robust error handling with fallbacks for file operations.
- **Rationale:** Improve reliability on different Android versions and storage configurations.
- **Consequences:** Better user experience, reduced crashes, more complex code paths to maintain.

## ADR-007: Debug Menu and Logs Screen
- **Date:** 2025-04-08
- **Decision:** Add a debug menu with access to a dedicated logs screen.
- **Rationale:** Provide easy access to logs for debugging and support.
- **Consequences:** Improved troubleshooting capabilities, better user support, slight UI complexity increase.

---

_Add new architecture decisions here as the project evolves._