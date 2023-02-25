import 'package:flutter/material.dart';

class Note {
  String noteTitle;
  String? noteDescription;
  DateTime dateCreated;
  String? tag;
  Color? color;
  Note(
      {required this.noteTitle,
      this.noteDescription,
      required this.dateCreated});
}
