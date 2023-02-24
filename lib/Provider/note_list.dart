import 'package:ebook/Model/note_model.dart';
import 'package:ebook/Services/db_services.dart';
import 'package:ebook/Services/firestore_service.dart';
import 'package:flutter/material.dart';

class Notes with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  DBHelper dbHelper = DBHelper();
  List<Note> _notes = [];
  List<Note> get notes => _notes;
  noteadd(Note note) async {
    _notes.add(note);
    firestoreService.createNote(
        note.noteTitle, note.noteDescription!, note.dateCreated);
    await DBHelper.insert('notes', {
      'id': note.dateCreated.toIso8601String(),
      'title': note.noteTitle,
      'description': note.noteDescription!
    });

    notifyListeners();
  }

  noteUpdate(Note upNote) async {
    Note note = _notes
        .where((element) => element.dateCreated == upNote.dateCreated)
        .first;
    note.noteTitle = upNote.noteTitle;
    note.noteDescription = upNote.noteDescription;
    firestoreService.updateNote(
        upNote.noteTitle, upNote.noteDescription!, upNote.dateCreated);
    await DBHelper.updateNote('notes', {
      'id': upNote.dateCreated.toIso8601String(),
      'title': upNote.noteTitle,
      'description': upNote.noteDescription!
    });
    notifyListeners();
  }

  fetchNotes() async {
    final dataList = await DBHelper.getNotes('notes');
    _notes = dataList
        .map((e) => Note(
            noteTitle: e['title'] as String,
            noteDescription: e['description'] as String,
            dateCreated: DateTime.parse(e['id'] as String)))
        .toList();
    notifyListeners();
  }

  deleteNote(DateTime id) async {
    _notes.removeAt(_notes.indexWhere((element) => element.dateCreated == id));
    await DBHelper.deleteNote('notes', id.toIso8601String());
    firestoreService.deleteNote(id.toIso8601String());
    notifyListeners();
  }
}
