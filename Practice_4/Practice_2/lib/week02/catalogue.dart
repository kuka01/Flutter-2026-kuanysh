import 'models.dart';

class Library {
  final List<LibraryItem> items = [];

  late final DateTime openedAt;

  String? _cachedReport;

  void add(LibraryItem item) {
    items.add(item);
  }

  void open() {
    openedAt = DateTime.now();
  }

  Book? findByTitle(String title) {
    return items
        .whereType<Book>()
        .where((book) => book.title == title)
        .firstOrNull;
  }

  String countryOf(String title) =>
      findByTitle(title)?.author.country ?? 'unknown';

  List<String> get allTitles =>
      items.map((item) => item.title).toList();

  List<Book> get booksAfter2010 =>
      items.whereType<Book>().where((book) => book.year > 2010).toList();

  double get averagePages {
    final books = items.whereType<Book>().toList();

    // fold works with an empty collection, unlike reduce.
    return books.isEmpty
        ? 0
        : books.fold<int>(0, (sum, book) => sum + book.pages) /
            books.length;
  }

  Map<String, int> get booksPerAuthor =>
      items.whereType<Book>().fold<Map<String, int>>(
        {},
        (result, book) => {
          ...result,
          book.author.name: (result[book.author.name] ?? 0) + 1,
        },
      );

  Set<String> get authorNames =>
      items.whereType<Book>().map((book) => book.author.name).toSet();

  Set<Genre> get genres =>
      items.whereType<Book>().map((book) => book.genre).toSet();

  List<String> get displayList {
    final books = items.whereType<Book>().toList();

    return [
      'CATALOGUE',
      for (final book in books) '${book.title} (${book.year})',
      ...books.map((book) => book.author.name),
      if (books.any((book) => book.pages == 0)) '(incomplete data)',
    ];
  }

  String buildReport() {
    return _cachedReport ??= displayList.join('\n');
  }
}