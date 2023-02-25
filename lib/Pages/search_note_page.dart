import 'package:ebook/Widgets/note_card.dart';
import 'package:ebook/Widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../Provider/note_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  static String pageRoute = '/search=page';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    final searchQuery = provider.searchQuery;
    final notes = searchQuery.isEmpty
        ? provider.notes
        : provider.notes
            .where((note) => note.noteTitle
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 14, 18, 26),
        body: Column(
          children: [
            SearchBar(
                funtion: (seacrh) => provider.setSearchQuery(seacrh ?? ''),
                isSearch: true),
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
                return NoteCard(notes: notes, index: index);
              },
            ))
          ],
        ),
      ),
    );
  }
}
