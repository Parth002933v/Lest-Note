import 'package:flutter/material.dart';
import 'package:lets_note/main.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    required GlobalKey<ScaffoldState> drawerkey,
  }) : _drawerkey = drawerkey;

  final TextEditingController controller;
  final GlobalKey<ScaffoldState> _drawerkey;

  @override
  Widget build(BuildContext context) {
    // padding of Entire searchBar
    return Padding(
      padding: EdgeInsets.only(
        right: mq.width * 0.04,
        left: mq.width * 0.04,
        top: mq.height * 0.01,
      ),

      // Search Bar
      child: SearchBar(
        // controller
        controller: controller,

        elevation: MaterialStateProperty.all(0),

        // Drawer Icon
        leading: IconButton(
            tooltip: "Open Navigation Drawer",
            onPressed: () {
              _drawerkey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu)),

        // Icons of grid and profile
        trailing: [
          // Grid Icons
          IconButton(
              tooltip: "Change Grid View",
              onPressed: () {},
              icon: const Icon(Icons.grid_on_outlined)),

          // Profile Icon
          Padding(
            padding: EdgeInsets.only(right: mq.width * .04),
            child: IconButton(
                tooltip: "Profile",
                onPressed: () {},
                icon: Icon(Icons.account_circle_outlined)),
          )
        ],

        // Background colour of Searchbar
        backgroundColor: MaterialStateProperty.all(const Color(0xffe9f0f6)),

        // Hint of searchbar
        hintText: "Search your notes",

        // Hint of searchbar style
        hintStyle: MaterialStateProperty.all(const TextStyle(
            fontWeight: FontWeight.w400, color: Color(0xff484f55))),
      ),
    );
  }
}
