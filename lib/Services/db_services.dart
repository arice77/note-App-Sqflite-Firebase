import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'notes.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes(id TEXT PRIMARY KEY,title TEXT,description TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getNotes(String table) async {
    final db = await DBHelper.database();
    return await db.query(table);
  }

  static Future<int> updateNote(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    return await db.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
}
