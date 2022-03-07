import 'package:note_book/Database/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabase {
  NoteDatabase._init();

  static final instance = NoteDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('note.db');
    return _database!;
  }

  Future _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String boolType = 'BOOLEAN NOT NULL';
    const String integerType = 'INTEGER NOT NULL';
    const String textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableNote(
    ${NoteFields.id} $idType,
    ${NoteFields.number} $integerType,
    ${NoteFields.isImportant} $boolType,
    ${NoteFields.title} $textType,
    ${NoteFields.description} $textType,
    ${NoteFields.time} $textType
    )''');
  }

  Future<Note> createNote(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNote, note.toJson());

    return note.copy(id: id);
  }

  Future<Note> readOnlyOnceNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableNote,
        columns: NoteFields.value,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found !');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = '${NoteFields.time} ASC';
    final result = await db.query(tableNote, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    return await db.update(tableNote, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableNote, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
