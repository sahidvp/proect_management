// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:project_management_app/model/project_model.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('projects.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE projects (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             projectName TEXT NOT NULL,
//             status TEXT NOT NULL,
//             location TEXT NOT NULL,
//             startDate TEXT NOT NULL,
//             endDate TEXT NOT NULL
//           )
//         ''');
//       },
//     );
//   }

//   Future<int> insertProject(ProjectModel project) async {
//     final db = await instance.database;
//     return await db.insert('projects', project.toMap());
//   }

//   Future<List<ProjectModel>> getProjects() async {
//     final db = await instance.database;
//     final result = await db.query('projects');
//     return result.map((json) => ProjectModel.fromMap(json)).toList();
//   }
// }


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:project_management_app/model/project_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('projects.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE projects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            projectName TEXT NOT NULL,
            location TEXT NOT NULL,
            startDate TEXT NOT NULL,
            endDate TEXT NOT NULL,
            status TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertProject(ProjectModel project) async {
    final db = await instance.database;
    return await db.insert('projects', project.toMap());
  }

  Future<List<ProjectModel>> getProjects() async {
    final db = await instance.database;
    final result = await db.query('projects');
    return result.map((json) => ProjectModel.fromMap(json)).toList();
  }

  Future<int> updateProject(ProjectModel project) async {
    final db = await instance.database;
    return await db.update(
      'projects',
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  Future<int> deleteProject(int id) async {
    final db = await instance.database;
    return await db.delete(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
