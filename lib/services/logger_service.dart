import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

/// A service for logging app events, errors, and diagnostics
class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  static const String _logFileName = 'cosmoscribe_log.txt';
  static const int _maxLogSizeBytes = 5 * 1024 * 1024; // 5MB max log size
  static const int _maxLogEntries = 1000; // Maximum number of log entries to keep in memory
  
  File? _logFile;
  List<String> _memoryLogs = [];
  bool _initialized = false;

  /// Factory constructor to return the same instance
  factory LoggerService() {
    return _instance;
  }

  /// Private constructor
  LoggerService._internal();

  /// Initialize the logger service
  Future<void> init() async {
    if (_initialized) return;
    
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logDirPath = path.join(directory.path, 'Logs');
      final logDir = Directory(logDirPath);
      
      if (!await logDir.exists()) {
        await logDir.create(recursive: true);
      }
      
      _logFile = File(path.join(logDirPath, _logFileName));
      
      // Check if log file is too large and rotate if needed
      if (await _logFile!.exists()) {
        final fileSize = await _logFile!.length();
        if (fileSize > _maxLogSizeBytes) {
          await _rotateLogFile();
        }
      }
      
      _initialized = true;
      
      // Log app startup
      log('===== APP STARTED =====');
      log('Device: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');
      log('App Version: 0.2.0+2');
    } catch (e) {
      debugPrint('Error initializing logger: $e');
    }
  }

  /// Rotate the log file (create a backup and start fresh)
  Future<void> _rotateLogFile() async {
    try {
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final backupPath = '${_logFile!.path}.$timestamp.bak';
      await _logFile!.copy(backupPath);
      await _logFile!.writeAsString(''); // Clear the file
    } catch (e) {
      debugPrint('Error rotating log file: $e');
    }
  }

  /// Log a message with timestamp and level
  Future<void> log(String message, {LogLevel level = LogLevel.info}) async {
    final timestamp = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now());
    final logEntry = '[$timestamp] [${level.name.toUpperCase()}] $message';
    
    // Always print to console in debug mode
    debugPrint(logEntry);
    
    // Store in memory buffer (limited size)
    _memoryLogs.add(logEntry);
    if (_memoryLogs.length > _maxLogEntries) {
      _memoryLogs.removeAt(0);
    }
    
    // Write to file if initialized
    if (_initialized && _logFile != null) {
      try {
        await _logFile!.writeAsString('$logEntry\n', mode: FileMode.append);
      } catch (e) {
        debugPrint('Error writing to log file: $e');
      }
    }
  }

  /// Log an error with stack trace
  Future<void> logError(String message, [dynamic error, StackTrace? stackTrace]) async {
    String errorMsg = message;
    
    if (error != null) {
      errorMsg += '\nError: $error';
    }
    
    if (stackTrace != null) {
      errorMsg += '\nStack Trace:\n$stackTrace';
    }
    
    await log(errorMsg, level: LogLevel.error);
  }

  /// Log a warning
  Future<void> logWarning(String message) async {
    await log(message, level: LogLevel.warning);
  }

  /// Log debug information
  Future<void> logDebug(String message) async {
    await log(message, level: LogLevel.debug);
  }

  /// Get all logs as a single string
  String getLogsAsString() {
    return _memoryLogs.join('\n');
  }

  /// Get the path to the log file
  Future<String?> getLogFilePath() async {
    if (_initialized && _logFile != null) {
      return _logFile!.path;
    }
    return null;
  }

  /// Share or export logs
  Future<File?> getLogFile() async {
    if (_initialized && _logFile != null) {
      return _logFile;
    }
    return null;
  }

  /// Clear all logs
  Future<void> clearLogs() async {
    _memoryLogs.clear();
    
    if (_initialized && _logFile != null) {
      try {
        await _logFile!.writeAsString('');
        await log('Logs cleared by user');
      } catch (e) {
        debugPrint('Error clearing log file: $e');
      }
    }
  }
}

/// Log levels for different types of messages
enum LogLevel {
  debug,
  info,
  warning,
  error,
}
