import 'package:flutter/material.dart';
import 'models/book.dart';

enum BookAction { toggleRead, delete }

class DetailScreen extends StatelessWidget {
  final Book book;

  const DetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final yearText = book.year != null ? '${book.year}' : 'Year unknown';

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('Author: ${book.author}', style: theme.textTheme.titleMedium),
            Text('Pages: ${book.pages}', style: theme.textTheme.bodyMedium),
            Text('Year: $yearText', style: theme.textTheme.bodyMedium),
            Text('Status: ${book.read ? "Read" : "Unread"}',
                style: theme.textTheme.bodyMedium),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(BookAction.toggleRead);
                    },
                    child: Text(book.read ? 'Mark as unread' : 'Mark as read'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.errorContainer,
                    ),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Delete '${book.title}'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (!context.mounted) return;
                      if (confirm == true) {
                        Navigator.of(context).pop(BookAction.delete);
                      }
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: theme.colorScheme.onErrorContainer),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}