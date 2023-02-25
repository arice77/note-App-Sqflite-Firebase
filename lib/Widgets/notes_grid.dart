import 'package:ebook/Provider/note_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'note_card.dart';

class NotesGrid extends StatelessWidget {
  final Notes notesProvider;
  const NotesGrid({
    super.key,
    required this.notesProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MasonryGridView.count(
      itemCount: notesProvider.notes.length,
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        return Dismissible(
            direction: DismissDirection.horizontal,
            onDismissed: (_) {
              notesProvider.deleteNote(notesProvider.notes[index].dateCreated);
            },
            key: Key(notesProvider.notes[index].dateCreated.toIso8601String()),
            child: NoteCard(notes: notesProvider.notes, index: index));
      },
    ));
  }
}
