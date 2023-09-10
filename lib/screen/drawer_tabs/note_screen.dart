import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lets_note/api/apis.dart';
import 'package:lets_note/main.dart';
import 'package:lets_note/model/chat_model.dart';
import 'package:lets_note/widget/custom_search_bar.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key, required this.drawerkey});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> drawerkey;
  // to store all notes of the perticular instance in form of ChatModel
  List<NoteModel> notes = [];
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 7,
      trackVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Search Bar
            CustomSearchBar(controller: controller, drawerkey: drawerkey),

            // "All" text
            Container(
              margin: EdgeInsets.only(
                left: mq.width * 0.05,
                top: mq.height * 0.01,
                bottom: mq.height * 0.01,
              ),
              alignment: Alignment.centerLeft,
              child:
                  const Text('All', style: TextStyle(color: Color(0xff7f8082))),
            ),

            // Padding for grid view of notes
            Padding(
              padding: EdgeInsets.only(
                left: mq.width * 0.02,
                right: mq.width * 0.02,
                bottom: mq.height * 0.01,
              ),

              // Grid view of notes
              child: StreamBuilder(
                stream: APIs.getNotesStream(),
                builder: (context, snapshot) {
                  // if data is loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // if data got an error
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  // if data is empty
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No data Found !',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }

                  // take all note instance of id and map it and and add that
                  // value in notes from json to dart
                  notes = snapshot.data!.docs
                      .map((e) => NoteModel.fromJson(e.data()))
                      .toList();

                  // make propar grid view
                  return MasonryGridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,

                    shrinkWrap: true,

                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),

                    // nake how many instance of note id we get
                    itemCount: notes.length,

                    // Build note preview
                    itemBuilder: (context, index) {
                      // Get each document value of note instance with index
                      var note = notes[index];

                      // print the data in containor
                      return Container(
                        //    constraints: BoxConstraints(maxHeight: 200), // Set maximum height here
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff7f8082)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // note tital
                            Offstage(
                              offstage: note.title.isEmpty ? true : false,
                              child: Text(
                                note.title, // Access title from note
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            // note content
                            Text(
                              note.content, // Access content from note
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: GoogleFonts.roboto(
                                color: const Color(0xff7f8082),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
