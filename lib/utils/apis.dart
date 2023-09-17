import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_note/model/chat_model.dart';
import 'package:lets_note/theme/theme_getter.dart';

class APIs {
  // For accessing cloud Firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to fetch the data of notes
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
    return firestore
        .collection("users")
        .doc("swIKzsoSQUl36XkXNJcV") // my user id
        .collection("notes")
        .orderBy('noteID', descending: true) // notes
        .snapshots();
  }

  // create the reference of that path location where we store the data
  static CollectionReference<Map<String, dynamic>> ref = firestore
      .collection("users")
      .doc("swIKzsoSQUl36XkXNJcV")
      .collection("notes");

  // to add data in firestore
  static Future<void> addNote(
      {required String tital,
      required String content,
      required String timeID}) async {
    //messages sending time(also used as id)
    //final time = DateTime.now().millisecondsSinceEpoch.toString();

    // save the model formate data in noteData to send it in firestore
    final noteData = NoteModel(
      noteID: timeID,
      createdAt: timeID,
      title: tital,
      content: content,
      updatedAt: "",
    );

    // send the data in that reference with create the doc(time) file name.
    // also convert that data into json formate
    await ref.doc(timeID).set(noteData.toJson());
  }

  // Update the frestore data

  static Future<void> updateNote(
      {required String noteID,
      required String title,
      required String content}) async {
    await ref.doc(noteID).update({'title': title, 'content': content});
  }
}
