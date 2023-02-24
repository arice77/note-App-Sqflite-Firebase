class Note {
  String noteTitle;
  String? noteDescription;
  DateTime dateCreated;
  Note(
      {required this.noteTitle,
      this.noteDescription,
      required this.dateCreated});
}
