import 'package:flutter/material.dart';
import 'package:lets_note/theme/theme_data.dart';

import '../main.dart';
import '../screen/HomeScreen.dart';
import 'custom_drawer_button.dart';

class CustomeDrawer extends StatelessWidget {
  const CustomeDrawer({
    super.key,
    required this.isDarkMode,
    required this.notifierSeletctedButton,
  });

  final bool isDarkMode;
  final ValueNotifier notifierSeletctedButton;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode ? DarkThemeData.drawerBackgroundColor : null,
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
                isSelected_2:
                    notifierSeletctedButton.value == EnumDrawerButtonName.notes,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Labels"),
                    TextButton(
                      onPressed: () {},
                      child: Text('Edit',
                          style: TextStyle(
                              color: DarkThemeData.searchBarDrawerColor1)),
                    )
                  ],
                ),
              ),

              // Dekkd
              CustomDrawerButton1(
                enum_: EnumDrawerButtonName.dekkd,
                notifierSeletctedButton: notifierSeletctedButton,
                isSelected_2:
                    notifierSeletctedButton.value == EnumDrawerButtonName.dekkd,
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
                isSelected_2:
                    notifierSeletctedButton.value == EnumDrawerButtonName.help,
                icon: const Icon(Icons.help_outline),
                label: "Help & feedback",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
