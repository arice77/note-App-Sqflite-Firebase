import 'package:ebook/Pages/create_note_page.dart';
import 'package:ebook/Pages/search_note_page.dart';
import 'package:ebook/Provider/note_list.dart';
import 'package:ebook/Widgets/note_card.dart';
import 'package:ebook/Widgets/notes_grid.dart';
import 'package:ebook/Widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});
  static String routeName = '/notes-page';

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
          future: Provider.of<Notes>(context).fetchNotes(),
          builder: (context, snapshot) => Consumer<Notes>(
            builder: (context, value, child) {
              return Column(children: [
                GestureDetector(
                  child: SearchBar(
                    funtion: (_) {},
                    isSearch: false,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, SearchPage.pageRoute);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                NotesGrid(
                  notesProvider: value,
                ),
              ]);
            },
          ),
        ));
  }
}
