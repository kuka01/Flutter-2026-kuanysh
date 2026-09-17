import 'models.dart';

sealed class ShelfState {}

class Empty extends ShelfState {}

class Ready extends ShelfState {
  final List<Book> books;

  Ready(this.books);
}

class Broken extends ShelfState {
  final String message;

  Broken(this.message);
}

String describe(ShelfState state) => switch (state) {
      Empty() => 'Shelf is empty',
      Ready(books: final books) => 'Shelf is ready with ${books.length} books',
      Broken(message: final message) => 'Shelf is broken: $message',
    };

({int count, double avgPages}) statsOf(List<Book> books) {
  final total = books.fold<int>(
    0,
    (sum, book) => sum + book.pages,
  );

  return (
    count: books.length,
    avgPages: books.isEmpty ? 0 : total / books.length,
  );
}