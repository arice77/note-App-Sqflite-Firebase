import 'package:ebook/Model/note_model.dart';
import 'package:ebook/Services/db_services.dart';
import 'package:ebook/Services/firestore_service.dart';
import 'package:flutter/material.dart';

class Notes with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  DBHelper dbHelper = DBHelper();
  List<Note> _notes = [];
  List<Note> get notes => _notes;
  String _searchQuery = '';

  String get searchQuery => _searchQuery;
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  noteadd(Note note) async {
    _notes.add(note);
    firestoreService.createNote(
        note.noteTitle, note.noteDescription, note.dateCreated, note.label);
    await DBHelper.insert('notes', {
      'id': note.dateCreated.toString(),
      'title': note.noteTitle,
      'description': note.noteDescription,
      'label': note.label,
    });

    notifyListeners();
  }

  noteUpdate(Note upNote) async {
    Note note = _notes
        .where((element) => element.dateCreated == upNote.dateCreated)
        .first;
    note.noteTitle = upNote.noteTitle;
    note.noteDescription = upNote.noteDescription;
    firestoreService.updateNote(upNote.noteTitle, upNote.noteDescription!,
        upNote.dateCreated, note.label);
    await DBHelper.updateNote('notes', {
      'id': upNote.dateCreated.toString(),
      'title': upNote.noteTitle,
      'description': upNote.noteDescription,
      'label': upNote.label,
    });
    notifyListeners();
  }

  fetchNotes() async {
    final dataList = await DBHelper.getNotes('notes');
    _notes = dataList
        .map((e) => Note(
            noteTitle: e['title'] as String,
            noteDescription: e['description'] as String,
            dateCreated: DateTime.parse(
              e['id'] as String,
            ),
            label: e['label'] as String))
        .toList();

    notifyListeners();
  }

  deleteNote(DateTime id) async {
    _notes.removeAt(_notes.indexWhere((element) => element.dateCreated == id));
    await DBHelper.deleteNote('notes', id.toString());
    notifyListeners();
    firestoreService.deleteNote(id.toString());
  }
}
