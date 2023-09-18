import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../model/chat_model.dart';
import '../../theme/theme_data.dart';

class SelectedNoteContainor extends StatelessWidget {
  const SelectedNoteContainor({
    super.key,
    required this.note,
    required this.isDarkMode,
  });

  final NoteModel note;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // note tital
            Offstage(
              offstage: note.title.isEmpty ? true : false,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: mq.height * 0.007,
                ),
                child: Text(
                  note.title, // Access title from note
                  maxLines: null,
                  //overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // note content
            Text(
              note.content, // Access content from note
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: GoogleFonts.roboto(
                color: isDarkMode
                    ? DarkThemeData.noteTextColor
                    : LightThemeData.noteTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
