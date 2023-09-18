import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lets_note/helper/helper.dart';
import 'package:lets_note/providers/selection_provider.dart';
import 'package:lets_note/theme/theme_data.dart';
import 'package:lets_note/theme/theme_getter.dart';
import 'package:lets_note/utils/apis.dart';
import 'package:lets_note/main.dart';
import 'package:lets_note/model/chat_model.dart';
import 'package:lets_note/screen/add_note.dart';
import 'package:lets_note/widget/custom_search_bar.dart';

import '../../widget/note_screen_widget/none_selected_note_containor.dart';
import '../../widget/note_screen_widget/selected_note_containor.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key, required this.drawerkey});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> drawerkey;

  // ValueNotifier
  final ValueNotifier<bool> isSelected = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    // to store all notes of the perticular instance in form of ChatModel
    List<NoteModel> notes = [];

    // Scrollbar to show indecator of scroll
    return Scrollbar(
      thickness: 5,
      trackVisibility: true,

      // To add scroll
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Search Bar and selectionbar
            ValueListenableBuilder(
                valueListenable: isSelected,
                builder: (context, value, child) {
                  // is isSelected is true it will change accordingly
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      statusBarColor: isSelected.value
                          ? DarkThemeData.floatingButtonColor
                          : Colors.transparent,
                      statusBarIconBrightness:
                          isDarkMode ? Brightness.light : Brightness.dark,
                      systemNavigationBarColor: isDarkMode
                          ? DarkThemeData.floatingButtonColor
                          : LightThemeData.floatingButtonColor,
                      systemNavigationBarIconBrightness:
                          isDarkMode ? Brightness.light : Brightness.dark,
                    ),
                  );

                  // for change the widget accordingly isSelected
                  return Visibility(
                    visible: isSelected.value,

                    // is isSelected == true
                    replacement: CustomSearchBar(
                        controller: controller, drawerkey: drawerkey),

                    // is isSelected == false
                    child: Container(
                      // BackgroundColor change according to themeMode
                      color: isDarkMode
                          ? DarkThemeData.floatingButtonColor
                          : LightThemeData.floatingButtonColor,

                      // use riverpod
                      child: Consumer(
                        builder: (context, ref, child) => Row(
                          children: [
                            Row(
                              children: [
                                // close Icon
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: mq.width * 0.02),
                                  child: IconButton(
                                      tooltip: "Close",
                                      onPressed: () {
                                        isSelected.value = ref
                                            .read(selectionProvider.notifier)
                                            .clearTheState();

                                        ref.refresh(selectionProvider);
                                      },
                                      icon: const Icon(Icons.close)),
                                ),

                                // Number of selected Notes
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: mq.width * 0.03),
                                  child: Text(
                                    ref
                                        .watch(selectionProvider)
                                        .length
                                        .toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(width: mq.width * 0.025),
                              ],
                            ),
                            //SizedBox(width: mq.width * 0.1),

                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    tooltip: "Pin",
                                    onPressed: () {},
                                    icon: const Icon(Icons.push_pin_outlined)),
                                IconButton(
                                    tooltip: "Select All",
                                    onPressed: () {},
                                    icon: const Icon(Icons.select_all)),
                                PopupMenuButton(
                                  icon: Icon(Icons.more_vert_rounded,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black54),
                                  color: isDarkMode
                                      ? DarkThemeData.floatingButtonColor
                                      : LightThemeData.floatingButtonColor,
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                        value: 1, child: Text('Archive')),
                                    PopupMenuItem(
                                      value: 2,
                                      child: const Text('Delete'),
                                      onTap: () {
                                        final wantToDelete =
                                            ref.watch(selectionProvider);

                                        APIs.Delete(wantToDelete).then(
                                            (value) => ref
                                                .watch(
                                                    selectionProvider.notifier)
                                                .clearTheState());
                                        helper.showScaffoldMessage(
                                          'Your Note Has been deleted',
                                          context,
                                        );

                                        isSelected.value = false;
                                      },
                                    ),
                                    const PopupMenuItem(
                                        value: 3, child: Text('Make a copy')),
                                    const PopupMenuItem(
                                        value: 4, child: Text('Send')),
                                    const PopupMenuItem(
                                        value: 4,
                                        child: Text('Copy to Google Docs')),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),

            // "All" text
            Container(
              margin: EdgeInsets.only(
                left: mq.width * 0.05,
                top: mq.height * 0.01,
                bottom: mq.height * 0.01,
              ),
              alignment: Alignment.centerLeft,
              child: const Column(
                children: [
                  //Text(selectedList.length.toString()),
                  Text('All')
                ],
              ),
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
                      NoteModel note = notes[index];

                      // print the data in containor
                      // to update the note
                      return Consumer(builder: (context, ref, child) {
                        final isselectedContainor =
                            ref.watch(selectionProvider);

                        return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onLongPress: () async {
                            isSelected.value = ref
                                .read(selectionProvider.notifier)
                                .select(note.noteID);
                          },
                          onTap: () {
                            if (!isSelected.value) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddNoteScreen(
                                      notes: note, isUpdate: true)));
                            } else {
                              isSelected.value = ref
                                  .read(selectionProvider.notifier)
                                  .select(note.noteID);
                            }
                          },
                          child: isSelected.value
                              ? isselectedContainor.contains(note.noteID)
                                  ? SelectedNoteContainor(
                                      note: note, isDarkMode: isDarkMode)
                                  : NoneSelectedNoteContainor(
                                      note: note, isDarkMode: isDarkMode)
                              : NoneSelectedNoteContainor(
                                  note: note, isDarkMode: isDarkMode),
                        );
                      });
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
