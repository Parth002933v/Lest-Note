import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_note/model/chat_model.dart';

class APIs {
  // For accessing cloud Firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to fetch the data of notes
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
    return firestore
        .collection("users")
        .doc("swIKzsoSQUl36XkXNJcV") // my user id
        .collection("notes") // notes
        .snapshots();
  }

  // to add data in firestore

  static Future<void> addNote(String title, String content) async {
    //messages sending time(also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // create the reference of that path location where we store the data
    final ref = firestore
        .collection("users")
        .doc("swIKzsoSQUl36XkXNJcV")
        .collection("notes");

    // save the model formate data in noteData to send it in firestore
    final noteData = NoteModel(
      createdAt: time.toString(),
      title: title,
      content: content,
      updatedAt: "",
    );

    // send the data in that reference with create the doc(time) file name.
    // also convert that data into json formate
    await ref.doc(time).set(noteData.toJson());
  }
}
