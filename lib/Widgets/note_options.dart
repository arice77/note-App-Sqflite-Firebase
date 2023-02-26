import 'package:ebook/Pages/notes_page.dart';
import 'package:ebook/Provider/note_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteOptions extends StatelessWidget {
  final bool notesExists;
  final double height;
  final DateTime id;
  const NoteOptions(
      {super.key,
      required this.height,
      required this.id,
      required this.notesExists});

  delete(Notes provider, BuildContext context) async {
    if (notesExists) {
      await provider.deleteNote(id);
    }

    Navigator.of(context).pushNamed(NotesPage.routeName);
  }

  label(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        color: const Color.fromARGB(255, 14, 18, 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'Label',
                  hintStyle: TextStyle(color: Colors.white),
                  focusColor: const Color.fromARGB(255, 50, 104, 254)),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Save',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 50, 104, 254)),
                ))
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    return Container(
      height: height * 1 / 3,
      color: const Color.fromARGB(255, 14, 18, 26),
      child: Column(
        children: [
          customListTile(
              Icons.delete, 'Delete note', () => delete(provider, context)),
          customListTile(Icons.copy, 'Make a copy', () => null),
          customListTile(Icons.share, 'Share', () {}),
          customListTile(Icons.label, 'Labels', () => label(context))
        ],
      ),
    );
  }

  ListTile customListTile(
      IconData iconData, String optionTitle, Function() function) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.white,
      ),
      title: Text(
        optionTitle,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: function,
    );
  }
}
