const String tableBooks = 'books';

class BookFields {
  static final List<String> values = [
    id, title, description, createdTime
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdTime = 'createdTime';
}

class Book {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;

  const Book({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Map<String, Object?> toJson() => {
    BookFields.id: id,
    BookFields.title: title, 
    BookFields.description: description,
    BookFields.createdTime: createdTime.toIso8601String(),
  };

  static Book fromJson(Map<String, Object?> json) => Book(
    id: json[BookFields.id] as int?,
    title: json[BookFields.title] as String,
    description: json[BookFields.description] as String,
    createdTime: DateTime.parse(json[BookFields.createdTime] as String)
  );

  Book copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) => Book(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdTime: createdTime ?? this.createdTime
  );
}