import 'package:ebook/Pages/auth_page.dart';
import 'package:ebook/Pages/create_note_page.dart';
import 'package:ebook/Pages/notes_page.dart';
import 'package:ebook/Provider/note_list.dart';
import 'package:ebook/Services/auth_services.dart';
import 'package:ebook/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isLoggedin = await AuthService().loggedIn();
  runApp(MyApp(
    isLoggedIn: isLoggedin,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Notes(),
      child: MaterialApp(
        routes: {
          NotesPage.routeName: (context) => const NotesPage(),
          CreateNotePage.routeName: (context) => CreateNotePage(edit: false),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0x000001d5),
        ),
        home: isLoggedIn ? const NotesPage() : const AuthPage(),
      ),
    );
  }
}
