import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String?) funtion;
  final bool isSearch;
  const SearchBar({super.key, required this.funtion, required this.isSearch});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: const Color.fromARGB(255, 22, 28, 39),
      elevation: 10,
      child: isSearch
          ? TextField(
              onChanged: funtion,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(94, 255, 255, 255),
                ),
                hintText: '     Search',
                hintStyle: const TextStyle(
                    color: Color.fromARGB(94, 255, 255, 255), fontSize: 20),
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
              cursorColor: Colors.white,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 9),
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    color: Color.fromARGB(94, 255, 255, 255),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                        color: Color.fromARGB(94, 255, 255, 255), fontSize: 15),
                  ),
                ],
              ),
            ),
    );
  }
}
