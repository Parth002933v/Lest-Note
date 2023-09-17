import 'package:flutter/material.dart';
import 'package:lets_note/main.dart';
import 'package:lets_note/screen/HomeScreen.dart';
import 'package:lets_note/theme/theme_data.dart';

import '../theme/theme_getter.dart';

class CustomDrawerButton1 extends StatelessWidget {
  const CustomDrawerButton1({
    super.key,
    required this.notifierSeletctedButton,
    required this.isSelected_2,
    required this.icon,
    required this.label,
    required this.enum_,
  });

  // take ValueNotifier value
  final ValueNotifier notifierSeletctedButton;

  // check if button is selected or not
  final bool isSelected_2;

  // take enum value of drawer
  final EnumDrawerButtonName enum_;

  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    return ValueListenableBuilder(
      valueListenable: notifierSeletctedButton,
      builder: (context, value, child) => Padding(
        // padding on button
        padding: EdgeInsets.symmetric(horizontal: mq.width * .02),
        child: TextButton.icon(
          // onPressed
          onPressed: () {
            notifierSeletctedButton.value = enum_;
            //  onPressd(label);

            Navigator.of(context).pop();
          },

          // button style
          style: ButtonStyle(
            // add some padding on button's content
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: mq.width * 0.03,
                vertical: mq.height * 0.0156,
              ),
            ),

            // Icon and Text Color (dark color)
            foregroundColor:
                MaterialStatePropertyAll(notifierSeletctedButton.value == enum_
                    ? isDarkMode
                        ? DarkThemeData.drawerTextColor
                        : LightThemeData.drawerTextColor
                    : isDarkMode
                        ? DarkThemeData.searchBarDrawerColor1
                        : Color(0xff0b1d27)),

            // position of button content
            alignment: Alignment.centerLeft,

            // Background button color
            backgroundColor: MaterialStateProperty.all(
              notifierSeletctedButton.value == enum_
                  ? isDarkMode
                      ? DarkThemeData.drawerButton
                      : LightThemeData.drawerButton
                  : Colors.transparent,
            ),
          ),

          // button Icon
          icon: icon,

          // Text And space after the Icon
          label: Row(
            children: [
              SizedBox(width: mq.width * 0.02),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
