import 'dart:developer';

import 'package:lets_note/helper/helper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../main.dart';
import '../../model/chat_model.dart';
import '../../providers/selection_provider.dart';
import '../../theme/theme_data.dart';
import '../../theme/theme_getter.dart';
import '../../utils/apis.dart';
import '../../widget/note_screen_widget/custom_searchbar.dart';
import '../../widget/note_screen_widget/none_selected_note_containor.dart';
import '../../widget/note_screen_widget/selected_note_containor.dart';
import '../add_note.dart';

class NoteScreen2 extends ConsumerWidget {
  NoteScreen2({super.key, required this.drawerkey});

  // key for open drawer
  final GlobalKey<ScaffoldState> drawerkey;

  // controller
  final TextEditingController controller = TextEditingController();

  // ValueNotifier of selection
  final ValueNotifier<bool> isSelected = ValueNotifier(false);

  // ValueNotifier of Seraching
  final ValueNotifier<bool> isSearch = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    // to store all notes of the perticular instance in form of ChatModel
    List<NoteModel> notes = [];

    log("ReBuild//////////////////////////////// ");
    // Scrollbar to show indecator of scroll

    log('Note Consumer Rebuild..............................');

    // watch the provider's data of all notes
    final fetchedNote = ref.watch(APIs.notesStreamProvider);

    closeSelection(ref);

    return Scaffold(
      body: Scrollbar(
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
                  print('object');

                  // for change the widget accordingly isSelected
                  return ValueListenableBuilder(
                    valueListenable: isSearch,
                    builder: (context, value, child) {
                      // is isSelected is true it will change accordingly
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          statusBarColor: isSearch.value || isSelected.value
                              ? isDarkMode
                                  ? DarkThemeData.floatingButtonColor
                                  : LightThemeData.floatingButtonColor
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
                      return Visibility(
                        visible: isSelected.value,
                        // is isSelected == true show searchbar
                        replacement: custome_searchbar(
                          isSearch: isSearch,
                          isDarkMode: isDarkMode,
                          drawerkey: drawerkey,
                          ref: ref,
                        ),

                        // is isSelected == false Show selection
                        child: Container(
                          // BackgroundColor change according to themeMode
                          color: isDarkMode
                              ? DarkThemeData.floatingButtonColor
                              : LightThemeData.floatingButtonColor,

                          // use riverpod
                          child: Consumer(
                            builder: (context, reff, child) => Row(
                              children: [
                                Row(
                                  children: [
                                    // close Icon
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mq.width * 0.02),
                                      child: IconButton(
                                          tooltip: "Close",
                                          onPressed: () {
                                            closeSelection(reff);
                                          },
                                          icon: const Icon(Icons.close)),
                                    ),

                                    // Number of selected Notes
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mq.width * 0.03),
                                      child: Text(
                                        reff
                                            .watch(selectionProvider)
                                            .length
                                            .toString(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(width: mq.width * 0.025),
                                  ],
                                ),

                                // add some sapace
                                const Spacer(),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Pin
                                    IconButton(
                                        tooltip: "Pin",
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.push_pin_outlined)),

                                    // Select All
                                    IconButton(
                                        tooltip: "Select All",
                                        onPressed: () {},
                                        icon: const Icon(Icons.select_all)),

                                    // see more
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

                                        // to delete selected Note
                                        PopupMenuItem(
                                          value: 2,
                                          child: const Text('Delete'),
                                          onTap: () async {
                                            // take notes to delete
                                            final wantToDelete =
                                                reff.read(selectionProvider);

                                            // delete form firebase
                                            await APIs.delete(wantToDelete);

                                            // clear the state provider
                                            // isSelected.value = reff
                                            //     .read(
                                            //         selectionProvider.notifier)
                                            //     .clearTheState();

                                            // clear the state provider and remove selection
                                            closeSelection(reff);

                                            if (context.mounted) {
                                              // show the dialoge msg
                                              helper.showScaffoldMessage(
                                                  'Your Note Has been deleted',
                                                  context);
                                            }
                                          },
                                        ),

                                        // show if only one note is selected
                                        if (reff
                                                .read(selectionProvider)
                                                .length ==
                                            1)
                                          PopupMenuItem(
                                            onTap: () {
                                              copyText(reff);
                                            },
                                            value: 3,
                                            child: const Text('copy text'),
                                          ),
                                        const PopupMenuItem(
                                            value: 4, child: Text('Send')),
                                        const PopupMenuItem(
                                            value: 5,
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
                    },
                  );
                },
              ),

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
                //padding
                padding: EdgeInsets.only(
                  left: mq.width * 0.02,
                  right: mq.width * 0.02,
                  bottom: mq.height * 0.01,
                ),

                // Grid view of notes
                child: fetchedNote.when(
                  // if provider has data
                  data: (data) {
                    log('Note Consumer Rebuild data ..............................');
                    // pass data value in our list of notes in form of NoteModel
                    notes = data.docs
                        .map((e) => NoteModel.fromJson(e.data()))
                        .toList();
                    log("pring data ${notes.map((e) => e.noteID)}");
                    log('Note Consumer Rebuild data ..............................');

                    return Consumer(builder: (context, refff, child) {
                      refff.watch(selectionProvider);
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
                          NoteModel noteValue = notes[index];

                          log('Note Consumer Rebuild data/Containor ..............................');

                          // print the data in containor
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onLongPress: () async {
                              log("Note Consumer long Pressed ${noteValue.noteID}");
                              // display selection bar
                              isSelected.value = refff
                                  .read(selectionProvider.notifier)
                                  .select(notes[index]);
                            },
                            onTap: () {
                              // if selection is false
                              if (!isSelected.value) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AddNoteScreen(
                                        notes: noteValue, isUpdate: true),
                                  ),
                                );
                              } else {
                                isSelected.value = refff
                                    .read(selectionProvider.notifier)
                                    .select(noteValue);
                              }
                            },
                            child: isSelected.value
                                ? refff
                                        .read(selectionProvider)
                                        .contains(noteValue)
                                    ? SelectedNoteContainor(
                                        note: noteValue, isDarkMode: isDarkMode)
                                    : NoneSelectedNoteContainor(
                                        note: noteValue, isDarkMode: isDarkMode)
                                : NoneSelectedNoteContainor(
                                    note: noteValue, isDarkMode: isDarkMode),
                          );
                        },
                      );
                    });
                  },

                  //if provider has error
                  error: (error, stack) => Text('Error: $error'),

                  // is data is loading
                  loading: () => CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: mq.height * 0.06,
        notchMargin: 9,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: const CircularNotchedRectangle(),
        color: isDarkMode
            ? DarkThemeData.floatingButtonColor
            : LightThemeData.floatingButtonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode
            ? const Color(0xff212a31)
            : LightThemeData.floatingButtonColor,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddNoteScreen(
              notes: null,
              timeID: DateTime.now().millisecondsSinceEpoch.toString(),
            ),
          ),
        ),
        child: const Icon(Icons.add, size: 35),
      ),
    );
  }

  // to copy the state txt
  void copyText(WidgetRef reff) {
    final noteToCopy = reff.read(selectionProvider);

    // to Cpoy The selected Text
    Clipboard.setData(
      ClipboardData(
        text: noteToCopy[0].content.toString(),
      ),
    );

    closeSelection(reff);

    //isSelected.value = false;
  }

  // to close selection
  void closeSelection(WidgetRef reff) {
    isSelected.value = reff.read(selectionProvider.notifier).clearTheState();

    final refresh = reff.refresh(selectionProvider);

    print(refresh);
  }
}
