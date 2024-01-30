import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task_model_class.dart';

class TaskDatabaseService {
  static final TaskDatabaseService _instance = TaskDatabaseService._internal();

  factory TaskDatabaseService() => _instance;

  TaskDatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    // Get the directory for the app's local database
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'tasks.db');

    // Open/create the database at a given path
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          note TEXT,
          isCompleted INTEGER,
          date TEXT,
          startTime TEXT,
          endTime TEXT,
          color INTEGER,
          remind INTEGER,
          priority TEXT
        )
      ''');
    });
  }

  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db.insert('tasks', task.toJson());
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        note: maps[i]['note'],
        isCompleted: maps[i]['isCompleted'],
        date: maps[i]['date'],
        startTime: maps[i]['startTime'],
        endTime: maps[i]['endTime'],
        color: maps[i]['color'],
        remind: maps[i]['remind'],
        priority: maps[i]['priority'],
      );
    });
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
