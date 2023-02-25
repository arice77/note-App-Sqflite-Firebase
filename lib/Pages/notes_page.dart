import 'package:ebook/Pages/create_note_page.dart';
import 'package:ebook/Provider/note_list.dart';
import 'package:ebook/Widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});
  static String routeName = '/notes-page';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    final search = provider.searchQuery;
    final notes = search.isEmpty
        ? provider.notes
        : provider.notes
            .where((note) =>
                note.noteTitle.toLowerCase().contains(search.toLowerCase()) ||
                note.noteDescription!
                    .toLowerCase()
                    .contains(search.toLowerCase()))
            .toList();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 50, 104, 254),
            onPressed: () {
              Navigator.pushNamed(context, CreateNotePage.routeName);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 14, 18, 26),
        appBar: AppBar(
            actions: [
              Switch(
                  value: false,
                  onChanged: (_) {},
                  thumbIcon: MaterialStateProperty.all(
                    const Icon(
                      Icons.dark_mode,
                      color: Colors.black,
                    ),
                  ))
            ],
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 14, 18, 26),
            title: const Text(
              'Notes',
              style: TextStyle(color: Colors.white),
            )),
        body: Column(children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            color: const Color.fromARGB(255, 22, 28, 39),
            elevation: 10,
            child: TextField(
              onChanged: (searchTerm) {
                provider.setSearchQuery(searchTerm);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(94, 255, 255, 255),
                ),
                hintText: '     Search',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(94, 255, 255, 255)),
                fillColor: const Color.fromARGB(255, 11, 0, 69),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: MasonryGridView.count(
            itemCount: notes.length,
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            itemBuilder: (context, index) {
              return Dismissible(
                  direction: DismissDirection.horizontal,
                  onDismissed: (_) {
                    provider.deleteNote(notes[index].dateCreated);
                  },
                  key: Key(notes[index].dateCreated.toIso8601String()),
                  child: NoteCard(notes: notes, index: index));
            },
          ))
        ]));
  }
}
