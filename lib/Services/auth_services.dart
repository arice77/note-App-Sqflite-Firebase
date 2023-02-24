import 'package:ebook/Services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();
  final String login = 'login';

  Future signUp(String userName, String email, String password,
      BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      if (firebaseAuth.currentUser != null) {
        firestoreService.setUserCollection(
            firebaseAuth.currentUser!.uid, userName);
        pref.setBool(login, true);

        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  Future logIn(String email, String password, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser != null) {
        pref.setBool(login, true);
        return true;
      }
    } on FirebaseException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  Future<bool> loggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(login) ?? false;
  }
}
