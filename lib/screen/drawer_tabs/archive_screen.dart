import 'package:flutter/material.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key, required this.drawerkey});
  final GlobalKey<ScaffoldState> drawerkey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              drawerkey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu)),
        const Center(
          child: Text("Archive Screer"),
        ),
      ],
    );
  }
}
