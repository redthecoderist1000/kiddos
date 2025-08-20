import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class HomeTask {
  final int? id;
  final String category;
  final int points;
  final String title;
  final bool done;
  final int iconCode;
  final int iconColorValue;
  final int colorValue;

  HomeTask({
    this.id,
    required this.category,
    required this.points,
    required this.title,
    required this.done,
    required this.iconCode,
    required this.iconColorValue,
    required this.colorValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'points': points,
      'title': title,
      'done': done ? 1 : 0,
      'iconCode': iconCode,
      'iconColorValue': iconColorValue,
      'colorValue': colorValue,
    };
  }

  factory HomeTask.fromMap(Map<String, dynamic> map) {
    return HomeTask(
      id: map['id'],
      category: map['category'],
      points: map['points'],
      title: map['title'],
      done: map['done'] == 1,
      iconCode: map['iconCode'],
      iconColorValue: map['iconColorValue'],
      colorValue: map['colorValue'],
    );
  }
}

class HomeTaskDbHelper {
  static final HomeTaskDbHelper instance = HomeTaskDbHelper._init();
  static Database? _database;

  HomeTaskDbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('home_tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE home_tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        points INTEGER,
        title TEXT,
        done INTEGER,
        iconCode INTEGER,
        iconColorValue INTEGER,
        colorValue INTEGER
      )
    ''');
  }

  Future<int> insertTask(HomeTask task) async {
    final db = await instance.database;
    return await db.insert('home_tasks', task.toMap());
  }

  Future<List<HomeTask>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('home_tasks');
    return result.map((map) => HomeTask.fromMap(map)).toList();
  }

  Future<int> updateTask(HomeTask task) async {
    final db = await instance.database;
    return await db.update(
      'home_tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'home_tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}