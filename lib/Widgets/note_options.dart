import 'package:ebook/Pages/notes_page.dart';
import 'package:ebook/Provider/note_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteOptions extends StatelessWidget {
  final Function labelFunction;
  final bool notesExists;
  final double height;
  final DateTime id;
  final TextEditingController labelController;
  final Function createCpyFunction;
  final Function shreNoteFunction;
  const NoteOptions({
    super.key,
    required this.height,
    required this.id,
    required this.notesExists,
    required this.labelController,
    required this.labelFunction,
    required this.createCpyFunction,
    required this.shreNoteFunction,
  });

  delete(Notes provider, BuildContext context) async {
    if (notesExists) {
      await provider.deleteNote(id);
    }

    Navigator.of(context).pushNamed(NotesPage.routeName);
  }

  label(BuildContext context, Notes provider) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        color: const Color.fromARGB(255, 14, 18, 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: labelController,
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: 'Label',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusColor: Color.fromARGB(255, 50, 104, 254)),
            ),
            TextButton(
                onPressed: () {
                  labelFunction();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Color.fromARGB(255, 50, 104, 254)),
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
          customListTile(Icons.copy, 'Make a copy', () => createCpyFunction()),
          customListTile(Icons.share, 'Share', () => shreNoteFunction()),
          customListTile(Icons.label, 'Labels', () => label(context, provider))
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
