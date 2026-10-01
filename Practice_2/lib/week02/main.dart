import 'data.dart';
import 'models.dart';
import 'catalogue.dart';
import 'shelf_state.dart';

void main() {
  final library = Library();

  final books = rawBooks.map(Book.fromJson).toList();

  for (final book in books) {
    library.add(book);
  }

  library.open();

  print('=== ALL BOOKS ===');
  for (final book in books) {
    print(book);
  }

  print('\n=== ALL TITLES ===');
  print(library.allTitles);

  print('\n=== BOOKS AFTER 2010 ===');
  print(library.booksAfter2010);

  print('\n=== AVERAGE PAGES ===');
  print(library.averagePages);

  print('\n=== BOOKS PER AUTHOR ===');
  print(library.booksPerAuthor);

  print('\n=== AUTHORS ===');
  print(library.authorNames);

  print('\n=== GENRES ===');
  print(library.genres);

  print('\n=== COUNTRY ===');
  print(library.countryOf('Clean Code'));
  print(library.countryOf('Design Patterns'));

  print('\n=== DISPLAY LIST ===');
  print(library.buildReport());

  print('\n=== STATS RECORD ===');
  final stats = statsOf(books);
  print('Count: ${stats.count}');
  print('Average pages: ${stats.avgPages}');

  print('\n=== SHELF STATES ===');

  final ShelfState empty = Empty();
  final ShelfState ready = Ready(books);
  final ShelfState broken = Broken('Catalogue unavailable');

  print(describe(empty));
  print(describe(ready));
  print(describe(broken));
}