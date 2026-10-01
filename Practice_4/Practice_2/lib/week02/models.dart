class Author {
  final String name;
  final String? country;

  const Author({
    required this.name,
    this.country,
  });

  @override
  String toString() => country == null ? name : '$name ($country)';
}

enum Genre {
  craft('Craft'),
  theory('Theory'),
  unknown('Unknown');

  final String label;

  const Genre(this.label);

  static Genre fromString(String? raw) {
    return switch (raw) {
      'craft' => Genre.craft,
      'theory' => Genre.theory,
      _ => Genre.unknown,
    };
  }
}

abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({
    required this.title,
    required this.year,
  });

  String describe();

  bool get isOld => year < 2000;
}

mixin Borrowable on LibraryItem {
  String borrowLabel() => 'Borrow: $title';
}

class Book extends LibraryItem with Borrowable {
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final titleValue = json['title'];
    final yearValue = json['year'];
    final pagesValue = json['pages'];
    final authorValue = json['author'];
    final countryValue = json['country'];
    final genreValue = json['genre'];
    final descriptionValue = json['description'];

    return Book(
      title: titleValue is String ? titleValue : 'Unknown',
      year: yearValue is int ? yearValue : 0,
      pages: pagesValue is int ? pagesValue : 0,
      author: Author(
        name: authorValue is String ? authorValue : 'Unknown',
        country: countryValue is String ? countryValue : null,
      ),
      genre: Genre.fromString(
        genreValue is String ? genreValue : null,
      ),
      description: descriptionValue is String ? descriptionValue : null,
    );
  }

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String describe() => '$title ($year) by ${author.name}';

  @override
  String toString() {
    return 'Book(title: $title, year: $year, pages: $pages, '
        'author: $author, genre: ${genre.label})';
  }
}

class Magazine extends LibraryItem {
  final int issue;

  const Magazine({
    required super.title,
    required super.year,
    required this.issue,
  });

  @override
  String describe() => '$title ($year), issue $issue';
}

class Ghost implements LibraryItem {
  @override
  final String title;

  @override
  final int year;

  const Ghost({
    required this.title,
    required this.year,
  });

  @override
  bool get isOld => year < 2000;

  @override
  String describe() => 'Ghost: $title ($year)';
}