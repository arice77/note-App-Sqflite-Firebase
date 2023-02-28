import 'package:flutter/material.dart';

class Note {
  String noteTitle;
  String? noteDescription;
  DateTime dateCreated;
  String? label;
  Color? color;
  Note(
      {required this.noteTitle,
      this.noteDescription,
      required this.dateCreated,
      this.label,
      this.color});
}
