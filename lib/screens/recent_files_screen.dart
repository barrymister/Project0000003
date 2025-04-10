import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../providers/file_history_provider.dart';
import '../models/file_history_model.dart';
import '../constants/theme_constants.dart';
import '../services/logger_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class RecentFilesScreen extends StatelessWidget {
  const RecentFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Files'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmClearHistory(context),
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: Consumer<FileHistoryProvider>(
        builder: (context, provider, child) {
          final recentFiles = provider.recentFiles;
          
          if (recentFiles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Recent Files',
                    style: AppTheme.headingStyle(context),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Files you create will appear here',
                    style: AppTheme.captionStyle(context),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: recentFiles.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final file = recentFiles[index];
              return _buildFileCard(context, file);
            },
          );
        },
      ),
    );
  }

  Widget _buildFileCard(BuildContext context, SavedFile file) {
    final formattedDate = DateFormat('MMM d, y h:mm a').format(file.savedAt);
    final fileExists = File(file.path).existsSync();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Icon(
          fileExists ? Icons.description : Icons.error_outline,
          color: fileExists 
              ? Theme.of(context).colorScheme.primary 
              : Theme.of(context).colorScheme.error,
        ),
        title: Text(
          file.name,
          style: AppTheme.subheadingStyle(context).copyWith(
            fontSize: 16,
            decoration: fileExists ? null : TextDecoration.lineThrough,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${file.templateName} • ${file.format.toUpperCase()}',
              style: AppTheme.captionStyle(context),
            ),
            Text(
              formattedDate,
              style: AppTheme.captionStyle(context).copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) => _handleMenuAction(context, value, file),
          itemBuilder: (context) => [
            if (fileExists) ...[
              const PopupMenuItem(
                value: 'open',
                child: Row(
                  children: [
                    Icon(Icons.open_in_new),
                    SizedBox(width: 8),
                    Text('Open'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 8),
                    Text('Share'),
                  ],
                ),
              ),
            ],
            const PopupMenuItem(
              value: 'remove',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Remove from History'),
                ],
              ),
            ),
          ],
        ),
        onTap: fileExists 
            ? () => _openFile(context, file)
            : () => _showFileNotFoundError(context, file),
      ),
    );
  }

  Future<void> _confirmClearHistory(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History?'),
        content: const Text(
          'This will remove all files from your history. The files themselves won\'t be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Store context in a local variable to avoid async gap issues
      final currentContext = context;
      if (!currentContext.mounted) return;
      Provider.of<FileHistoryProvider>(currentContext, listen: false).clearHistory();
    }
  }

  Future<void> _handleMenuAction(BuildContext context, String action, SavedFile file) async {
    switch (action) {
      case 'open':
        _openFile(context, file);
        break;
      case 'share':
        try {
          await Share.shareXFiles(
            [XFile(file.path)],
            sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Error Sharing File', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    e.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: const Duration(seconds: 6),
            ),
          );
        }
        break;
      case 'remove':
        Provider.of<FileHistoryProvider>(context, listen: false)
            .removeFile(file.path);
        break;
    }
  }

  Future<void> _openFile(BuildContext context, SavedFile file) async {
    final logger = LoggerService();
    logger.log('Attempting to open file: ${file.path}');
    
    try {
      // First check if file exists
      logger.log('Checking if file exists: ${file.path}');
      final fileExists = await File(file.path).exists();
      if (!fileExists) {
        logger.logError('File not found: ${file.path}');
        _showFileNotFoundError(context, file);
        return;
      }
      
      logger.log('File exists, proceeding with open attempt');

      // Try to open the file
      final uri = Uri.file(file.path);
      
      // Log debugging information
      logger.log('File URI: $uri');
      logger.log('File format: ${file.format}');
      logger.log('File size: ${await File(file.path).length()} bytes');
      
      // First try to open with external application
      bool canOpen = false;
      try {
        logger.log('Attempting to open file with external application');
        canOpen = await launchUrl(
          uri,
          mode: LaunchMode.externalNonBrowserApplication,
        );
        logger.log('Launch URL result: $canOpen');
      } catch (e) {
        logger.logError('Error launching URL with external app', e);
        // Try platform default mode as fallback
        try {
          logger.log('Attempting to open file with default mode as fallback');
          canOpen = await launchUrl(uri);
          logger.log('Fallback launch URL result: $canOpen');
        } catch (e) {
          logger.logError('Error launching URL with default mode', e);
        }
      }
      
      if (!canOpen) {
        // If we can't launch directly, show error
        logger.logError('Could not open file: No app available to handle this file type');
        // Store context in local variable to avoid async gap issues
        final currentContext = context;
        if (!currentContext.mounted) return;
        ScaffoldMessenger.of(currentContext).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Could not open file', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'No app found to open ${file.format.toUpperCase()} files.',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            action: SnackBarAction(
              label: 'Show Location',
              onPressed: () async {
                final folder = Uri.file(File(file.path).parent.path);
                logger.log('Attempting to open folder: $folder');
                if (!await launchUrl(
                  folder,
                  mode: LaunchMode.externalNonBrowserApplication,
                )) {
                  logger.logError('Could not open file location: $folder');
                  // Store context in local variable to avoid async gap issues
                  final folderContext = context;
                  if (!folderContext.mounted) return;
                  ScaffoldMessenger.of(folderContext).showSnackBar(
                    SnackBar(
                      content: const Text('Could not open file location'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
            ),
            duration: const Duration(seconds: 6),
          ),
        );
      }
    } catch (e, stackTrace) {
      // Log the error with stack trace
      logger.logError('Exception when opening file', e, stackTrace);
      // Check if context is still mounted
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Error Opening File', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                e.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 6),
        ),
      );
    }
  }

  void _showFileNotFoundError(BuildContext context, SavedFile file) {
    final logger = LoggerService();
    logger.log('Showing file not found dialog for: ${file.path}');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('File Not Found'),
        content: Text(
          'The file "${file.name}" could not be found. It may have been moved or deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logger.log('Removing file from history: ${file.path}');
              Provider.of<FileHistoryProvider>(context, listen: false)
                  .removeFile(file.path);
            },
            child: const Text('Remove from History'),
          ),
        ],
      ),
    );
  }
}
