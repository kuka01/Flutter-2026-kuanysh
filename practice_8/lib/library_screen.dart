import 'package:flutter/material.dart';
import 'add_book_screen.dart';
import 'detail_screen.dart';
import 'models/book.dart';
import 'package:reading_list/widgets/book_tile.dart';

enum Filter { all, unread, read }

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<Book> _books = [...seed];
  Filter _filter = Filter.all;

  List<Book> get _visible {
    return switch (_filter) {
      Filter.all => _books,
      Filter.unread => unread(_books),
      Filter.read => _books.where((b) => b.read).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reading list (${_visible.length})'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('${_books.length}',
                            style: theme.textTheme.headlineSmall),
                        Text('Books', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('${totalPages(_books)}',
                            style: theme.textTheme.headlineSmall),
                        Text('Pages', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('${unread(_books).length}',
                            style: theme.textTheme.headlineSmall),
                        Text('Unread', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: _filter == Filter.all,
                onSelected: (_) => setState(() => _filter = Filter.all),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Unread'),
                selected: _filter == Filter.unread,
                onSelected: (_) => setState(() => _filter = Filter.unread),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Read'),
                selected: _filter == Filter.read,
                onSelected: (_) => setState(() => _filter = Filter.read),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _visible.length,
              itemBuilder: (context, index) {
                final book = _visible[index];
                return GestureDetector(
                  onTap: () async {
                    final action = await Navigator.of(context).push<BookAction>(
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(book: book),
                      ),
                    );

                    if (!mounted) return;

                    if (action == BookAction.toggleRead) {
                      setState(() => book.read = !book.read);
                    } else if (action == BookAction.delete) {
                      setState(() => _books.remove(book));
                    }
                  },
                  child: BookTile(
                    book: book,
                    onToggle: () => setState(() => book.read = !book.read),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newBook = await Navigator.of(context).push<Book>(
            MaterialPageRoute(builder: (_) => const AddBookScreen()),
          );

          if (!mounted) return;
          if (newBook != null) {
            setState(() => _books.add(newBook));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}