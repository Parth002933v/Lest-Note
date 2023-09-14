import 'package:flutter/material.dart';
import 'package:lets_note/main.dart';
import 'package:lets_note/screen/add_note.dart';
import 'package:lets_note/screen/drawer_tabs/archive_screen.dart';
import 'package:lets_note/screen/drawer_tabs/create_new_lable_screen.dart';
import 'package:lets_note/screen/drawer_tabs/dekkd_screen.dart';
import 'package:lets_note/screen/drawer_tabs/delete_screen.dart';
import 'package:lets_note/screen/drawer_tabs/help_feedback_screen.dart';
import 'package:lets_note/screen/drawer_tabs/reminder_screen.dart';
import 'package:lets_note/screen/drawer_tabs/setting_screen.dart';
import 'package:lets_note/widget/custom_drawer_button.dart';

import 'drawer_tabs/note_screen.dart';

enum EnumDrawerButtonName {
  notes,
  reminder,
  dekkd,
  createNewLable,
  archive,
  delete,
  setting,
  help,
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Global key for opening Drawer
  final GlobalKey<ScaffoldState> drawerkey = GlobalKey();

  // whitch drawer button is selected
  final ValueNotifier notifierSeletctedButton =
      ValueNotifier(EnumDrawerButtonName.notes);

  @override
  Widget build(BuildContext context) {
    // Initialise media query to take screen size
    mq = MediaQuery.of(context).size;

    // Scaffold
    return Scaffold(
      // key
      key: drawerkey,

      // drawer
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,

          padding: EdgeInsets.only(
            top: mq.height * .03,
            // left: mq.width * .02,
            // right: mq.width * .02,
          ), // Add top padding here
          children: <Widget>[
            // Google logo and Text
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Google image
                Padding(
                  // padding from left of logo
                  padding: EdgeInsets.only(left: mq.width * .04),

                  // Container for resize the logo
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: mq.width * 0.2,
                    height: mq.height * 0.09,

                    //  Google logo
                    child: Image.asset(
                      "assets/images/Google.png",
                      matchTextDirection: true,
                      isAntiAlias: false,
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),

                //Text of Keep
                const Text(
                  " Keep",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 19,
                    color: Color(0xff7c7c7d),
                  ),
                )
              ],
            ),

            // Buttons

            // to re build all button UI
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notes
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.notes,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.notes,
                  icon: const Icon(Icons.lightbulb_outline),
                  label: "Notes",
                ),

                // Reminders
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.reminder,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.reminder,
                  icon: const Icon(Icons.notifications_none_outlined),
                  label: "Reminder",
                ),

                const Divider(),

                // Label Text
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mq.width * .05,
                    vertical: mq.height * .02,
                  ),
                  child: const Text("Labels"),
                ),

                // Dekkd
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.dekkd,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.dekkd,
                  icon: const Icon(Icons.label_outline_rounded),
                  label: "Reminder",
                ),

                // Create new lable
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.createNewLable,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.createNewLable,
                  icon: const Icon(Icons.add),
                  label: "Create new lable",
                ),

                //Divider
                const Divider(),

                // Archive
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.archive,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.archive,
                  icon: const Icon(Icons.archive_outlined),
                  label: "Archive",
                ),

                // Delete
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.delete,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.delete,
                  icon: const Icon(Icons.delete_forever_outlined),
                  label: "Delete",
                ),

                // Setting
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.setting,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.setting,
                  icon: const Icon(Icons.settings_outlined),
                  label: "Setting",
                ),

                // Help & feedback
                CustomDrawerButton1(
                  enum_: EnumDrawerButtonName.help,
                  notifierSeletctedButton: notifierSeletctedButton,
                  isSelected_2: notifierSeletctedButton.value ==
                      EnumDrawerButtonName.help,
                  icon: const Icon(Icons.help_outline),
                  label: "Help & feedback",
                ),
              ],
            ),
          ],
        ),
      ),
      // body
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: notifierSeletctedButton,
          builder: (context, value, child) {
            switch (value) {
              case EnumDrawerButtonName.notes:
                return NoteScreen(drawerkey: drawerkey);

              case EnumDrawerButtonName.reminder:
                return ReminderScreen();

              case EnumDrawerButtonName.dekkd:
                return DekkdScreen();

              case EnumDrawerButtonName.createNewLable:
                return CreateNewLableScreen();

              case EnumDrawerButtonName.archive:
                return ArchiveScreen(drawerkey: drawerkey);

              case EnumDrawerButtonName.delete:
                return DeleteScreen();

              case EnumDrawerButtonName.setting:
                return SettingScreen();

              case EnumDrawerButtonName.help:
                return HelpFeedbackScreen();

              default:
                return const Text('Error');
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffe7eef4),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddNoteScreen(
              notes: null,
              timeID: DateTime.now().millisecondsSinceEpoch.toString(),
            ),
          ),
        ),
        isExtended: true,
        child: const Icon(Icons.add),
      ),
    );
  }
}
