import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './todo_model.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'todo.db';
    final path = join(dbpath, dbname);

    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);

    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  Future<void> addTodo(TaskModel task) async {
    final db = await database;
    await db.insert(
      'todo',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(TaskModel task) async {
    final db = await database;
    await db.delete(
      'todo',
      where: 'id == ?',
      whereArgs: [task.id],
    );
  }

  Future<List<TaskModel>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );

    return List.generate(
      items.length,
      (i) => TaskModel(
        id: items[i]['id'],
        title: items[i]['title'],
        creationDate: DateTime.parse(items[i]['creationDate']),
        isChecked: items[i]['isChecked'] == 1 ? true : false,
      ),
    );
  }

  Future<void> updateTodo(int id, String title) async {
    final db = await database;

    await db.update(
      'todo',
      {
        'title': title,
      },
      where: 'id == ?',
      whereArgs: [id],
    );
  }
}
