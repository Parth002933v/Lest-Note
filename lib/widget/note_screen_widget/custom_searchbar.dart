import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../screen/drawer_tabs/note_screen.dart';
import '../../theme/theme_data.dart';
import '../../utils/apis.dart';

class custome_searchbar extends StatefulWidget {
  const custome_searchbar({
    super.key,
    required this.isSearch,
    required this.isDarkMode,
    required this.ref,
    required GlobalKey<ScaffoldState> drawerkey,
  }) : _drawerkey = drawerkey;

  final ValueNotifier<bool> isSearch;
  final bool isDarkMode;
  final GlobalKey<ScaffoldState> _drawerkey;

  final WidgetRef ref;

  @override
  State<custome_searchbar> createState() => _custome_searchbarState();
}

class _custome_searchbarState extends State<custome_searchbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // searchbar UI or Search
        Visibility(
          visible: widget.isSearch.value,
          replacement: Container(
            width: mq.width * 0.93,
            height: mq.height * 0.06,
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? DarkThemeData.searchBarColor
                  : LightThemeData.searchBarColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Drawer Icon
                Padding(
                  padding: EdgeInsets.only(left: mq.width * 0.025),
                  child: IconButton(
                      tooltip: "Open Navigation Drawer",
                      color: widget.isDarkMode
                          ? DarkThemeData.searchBarDrawerColor1
                          : null,
                      iconSize: 25,
                      onPressed: () {
                        widget._drawerkey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                ),

                // Search Hint text
                TextButton(
                    style: const ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    onPressed: () {
                      widget.isSearch.value = true;
                    },
                    child: Text(
                      'Search your notes',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: widget.isDarkMode
                            ? DarkThemeData.searchBarHintColor2
                            : LightThemeData.searchBarHintColor2,
                      ),
                    )),

                const Spacer(),
                // Grid Icons
                Padding(
                  padding: EdgeInsets.only(right: mq.width * 0.02),
                  child: Row(
                    children: [
                      IconButton(
                          tooltip: "Change Grid View",
                          onPressed: () {},
                          icon: const Icon(Icons.grid_view_outlined)),

                      // Profile Icon
                      Padding(
                        padding: EdgeInsets.only(right: mq.width * .04),
                        child: IconButton(
                            tooltip: "Profile",
                            onPressed: () {
                              widget.ref.refresh(APIs.notesStreamProvider);
                            },
                            icon: const Icon(Icons.account_circle_outlined)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? DarkThemeData.floatingButtonColor
                  : LightThemeData.floatingButtonColor,
            ),
            child: Row(
              children: [
                // back button
                IconButton(
                    onPressed: () {
                      widget.isSearch.value = false;
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        hintText: "Search your notes....",
                        hintStyle:
                            TextStyle(color: DarkThemeData.searchBarHintColor2),
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
