import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class DBHelper {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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

  static Future deleteNote(String table, String id) async {
    final db = await DBHelper.database();
    return await db.delete(table, where: 'id=?', whereArgs: [id]);
  }

  static Future syncfirebaseToLocal() async {
    String sqlPath = '${await sql.getDatabasesPath()}notes.db';
    final db = await DBHelper.database();
    if (!Directory(sqlPath).existsSync()) {
      QuerySnapshot<Map<String, dynamic>> onlineNote = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('notes')
          .get();

      for (var element in onlineNote.docs) {
        DBHelper.insert('notes', {
          'id': element['id'],
          'title': element['noteTitle'],
          'description': element['NoteDesc']
        });
        print(element['id']);
      }
    }
  }
}
