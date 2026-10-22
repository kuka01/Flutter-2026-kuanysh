import 'package:flutter/material.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final VoidCallback onToggle;

  const BookTile({
    super.key,
    required this.book,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final letter = book.title.isNotEmpty ? book.title[0].toUpperCase() : '?';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    letter,
                    style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                  ),
                ),
                if (!book.read)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${book.author} · ${book.pages} pp.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Checkbox(
              value: book.read,
              onChanged: (_) => onToggle(),
            ),
          ],
        ),
      ),
    );
  }
}