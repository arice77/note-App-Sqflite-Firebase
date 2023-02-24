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
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () => openEditor(context),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          color: const Color.fromARGB(255, 22, 28, 39),
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
                  notes[index].noteTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (notes[index].noteDescription!.isNotEmpty)
                  Text(
                    notes[index].noteDescription!.length > 200
                        ? notes[index].noteDescription!.substring(0, 200)
                        : notes[index].noteDescription ?? '',
                    style: const TextStyle(color: Colors.grey),
                    overflow: TextOverflow.clip,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
