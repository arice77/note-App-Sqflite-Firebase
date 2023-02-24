import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  setUserCollection(String uid, String userName) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .set({"username": userName});
  }

  createNote(String noteTitle, String noteDesc, DateTime id) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notes')
        .doc(id.toIso8601String())
        .set({
      'noteTitle': noteTitle,
      'NoteDesc': noteDesc,
      'id': id.toString()
    });
  }

  updateNote(String noteTitle, String noteDesc, DateTime id) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notes')
        .doc(id.toString())
        .set({
      'noteTitle': noteTitle,
      'NoteDesc': noteDesc,
      'id': id.toString()
    });
  }

  Future deleteNote(String id) async {
    return await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notes')
        .doc(id)
        .delete();
  }
}
