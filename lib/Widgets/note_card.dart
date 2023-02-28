import 'package:ebook/Model/note_model.dart';
import 'package:ebook/Pages/create_note_page.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.notes,
    required this.index,
  });

  final List<Note> notes;
  final int index;
  openEditor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateNotePage(
                initialTitle: notes[index].noteTitle,
                initialDesc: notes[index].noteDescription,
                edit: true,
                id: notes[index].dateCreated,
                label: notes[index].label,
                backgroundColor: notes[index].color,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final note = notes[index];
    return SizedBox(
      child: GestureDetector(
        onTap: () => openEditor(context),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          color: notes[index].color ?? const Color.fromARGB(255, 22, 28, 39),
          shadowColor: const Color.fromARGB(147, 2, 25, 44),
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.noteTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (note.noteDescription!.isNotEmpty)
                  Text(
                    note.noteDescription!.length > 200
                        ? note.noteDescription!.substring(0, 200)
                        : notes[index].noteDescription!,
                    style: const TextStyle(color: Colors.white60),
                    overflow: TextOverflow.clip,
                  ),
                if (notes[index].label!.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFF757575))),
                    child: Text(
                      notes[index].label!,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
