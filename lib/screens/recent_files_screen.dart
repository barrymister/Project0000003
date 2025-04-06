import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../providers/file_history_provider.dart';
import '../models/file_history_model.dart';
import '../constants/theme_constants.dart';

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
      // ignore: use_build_context_synchronously
      Provider.of<FileHistoryProvider>(context, listen: false).clearHistory();
    }
  }

  void _handleMenuAction(BuildContext context, String action, SavedFile file) {
    switch (action) {
      case 'open':
        _openFile(context, file);
        break;
      case 'share':
        // TODO: Implement file sharing
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sharing coming soon!')),
        );
        break;
      case 'remove':
        Provider.of<FileHistoryProvider>(context, listen: false)
            .removeFile(file.path);
        break;
    }
  }

  Future<void> _openFile(BuildContext context, SavedFile file) async {
    // TODO: Implement file opening logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File opening coming soon!')),
    );
  }

  void _showFileNotFoundError(BuildContext context, SavedFile file) {
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
