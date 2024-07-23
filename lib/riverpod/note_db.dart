import 'dart:convert';

import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
class DatabaseHelper {
  Database? db;
  final String tableName = 'Note';
// init data
  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'NoteList.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY,title TEXT NOT NULL,  content TEXT NOT NULL, image TEXT,   link TEXT,  time DATETIME NOT NULL, additionalContents TEXT)');
    });
  }

// ensure database initialized
  Future<void> _ensureDatabaseInitialized() async {
    if (db == null) {
      await initDatabase();
    }
  }

// insert data
  Future<Note> insert(Note note) async {
    await _ensureDatabaseInitialized();
    note.idNote = await db!.insert(tableName, note.toMap());
    return note;
  }
// function get all notes
  Future<List<Note>> getAllNote() async {
    await _ensureDatabaseInitialized();
    final List<Map<String, dynamic>> maps = await db!.query(tableName);
    return List.generate(maps.length, (i) {
      return Note(
          idNote: maps[i]['id'],
          title: maps[i]['title'],
          content: maps[i]['content'],
          image: maps[i]['image'],
          link: maps[i]['link'],
          time: maps[i]['time'],
          additionalContents: jsonDecode(maps[i]['additionalContents'])
          );
    });
  }

// function update note
  Future<int> update(Note note) async {
    try {
      return await db!.update(tableName, note.toMap(),
          where: 'id = ?', whereArgs: [note.idNote]);
    } catch (e) {
      return 1;
    }
  }

// remove  note
  Future<int> remove(Note note) async {
    return await db!
        .delete(tableName, where: 'id = ?', whereArgs: [note.idNote]);
  }
}

final databaseHelperProvider = Provider((ref) {
  return DatabaseHelper();
});
