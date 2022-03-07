const String tableNote = 'notes';

class NoteFields {
  static final List<String> value = [
    id,
    number,
    isImportant,
    title,
    description,
    time
  ];

  static const String id = '_id';
  static const String number = 'number';
  static const String isImportant = 'isImportant';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
  final int? id;
  final int number;
  final bool isImportant;
  final String title;
  final String description;
  final DateTime time;

  const Note(
      {this.id,
      required this.number,
      required this.isImportant,
      required this.title,
      required this.time,
      required this.description});

  Note copy(
      {int? id,
      int? number,
      bool? isImportant,
      String? title,
      String? description,
      DateTime? time}) {
    return Note(
        number: number ?? this.number,
        isImportant: isImportant ?? this.isImportant,
        title: title ?? this.title,
        time: time ?? this.time,
        description: description ?? this.description);
  }

  Map<String, Object> toJson() => {
        NoteFields.id: id!,
        NoteFields.number: number,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: time.toIso8601String()
      };

  static Note fromJson(Map<String, Object?> json) => Note(
      id: json[NoteFields.id] as int,
      number: json[NoteFields.number] as int,
      isImportant: json[NoteFields.isImportant ] == 1,
      title: json[NoteFields.title] as String,
      time: DateTime.parse(json[NoteFields.time] as String),
      description: json[NoteFields.description] as String);
}
