import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_note/main.dart';
import 'package:lets_note/screen/add_note.dart';
import 'package:lets_note/screen/drawer_tabs/archive_screen.dart';
import 'package:lets_note/screen/drawer_tabs/create_new_lable_screen.dart';
import 'package:lets_note/screen/drawer_tabs/dekkd_screen.dart';
import 'package:lets_note/screen/drawer_tabs/delete_screen.dart';
import 'package:lets_note/screen/drawer_tabs/help_feedback_screen.dart';
import 'package:lets_note/screen/drawer_tabs/reminder_screen.dart';
import 'package:lets_note/screen/drawer_tabs/setting_screen.dart';
import 'package:lets_note/theme/theme_data.dart';
import 'package:lets_note/theme/theme_getter.dart';
import 'package:lets_note/widget/custom_drawer_button.dart';

import '../widget/custome_drawer.dart';
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
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    //
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDarkMode
            ? DarkThemeData.floatingButtonColor
            : LightThemeData.floatingButtonColor,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    // Initialise media query to take screen size
    mq = MediaQuery.of(context).size;

    // Scaffold
    return Scaffold(
      backgroundColor: isDarkMode
          ? DarkThemeData.primaryBackgroundColor
          : LightThemeData.primaryBackgroundColor,

      // key
      key: drawerkey,

      // drawer
      drawer: CustomeDrawer(
          isDarkMode: isDarkMode,
          notifierSeletctedButton: notifierSeletctedButton),
      // body
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: notifierSeletctedButton,
          builder: (context, value, child) {
            switch (value) {
              case EnumDrawerButtonName.notes:
                return NoteScreen(drawerkey: drawerkey);

              case EnumDrawerButtonName.reminder:
                return const ReminderScreen();

              case EnumDrawerButtonName.dekkd:
                return const DekkdScreen();

              case EnumDrawerButtonName.createNewLable:
                return const CreateNewLableScreen();

              case EnumDrawerButtonName.archive:
                return ArchiveScreen(drawerkey: drawerkey);

              case EnumDrawerButtonName.delete:
                return const DeleteScreen();

              case EnumDrawerButtonName.setting:
                return const SettingScreen();

              case EnumDrawerButtonName.help:
                return const HelpFeedbackScreen();

              default:
                return const Text('Error');
            }
          },
        ),
      ),
    );
  }
}
