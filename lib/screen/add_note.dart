import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_note/utils/apis.dart';
import 'package:lets_note/main.dart';
import 'package:lets_note/model/chat_model.dart';

import '../theme/theme_getter.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
    required this.notes,
    this.isUpdate = false,
    this.timeID,
  });

  final NoteModel? notes;
  final bool isUpdate;
  final String? timeID;
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _descriptioncontroller = TextEditingController();
  final _titlecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isUpdate) {
      _titlecontroller.value = TextEditingValue(text: widget.notes!.title);
      _descriptioncontroller.value =
          TextEditingValue(text: widget.notes!.content);
    } else {
      _titlecontroller.clear();
      _descriptioncontroller.clear();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _titlecontroller.dispose();
    _descriptioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    return Scaffold(
      appBar: AppBar(
        // remove back button
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mq.width * 0.02),
                child: IconButton(
                  tooltip: "Navigate To Up",
                  color: isDarkMode ? Colors.white : Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    //color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        // GestureDetector
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

            // for tital and note
            child: Column(
              children: [
                // tital
                TextField(
                  onChanged: (value) async {
                    // to update the note
                    if (widget.isUpdate == true) {
                      log('update');
                      APIs.updateNote(
                          noteID: widget.notes!.noteID,
                          title: _titlecontroller.text,
                          content: _descriptioncontroller.text);
                    }
                    // // add a new note
                    else if (widget.isUpdate == false &&
                        _descriptioncontroller.text.isNotEmpty &&
                        _descriptioncontroller.text.trim().isNotEmpty &&
                        widget.timeID != null) {
                      //  timeID = DateTime.now().millisecondsSinceEpoch;

                      log('add');
                      await APIs.addNote(
                          timeID: widget.timeID!,
                          tital: _titlecontroller.text,
                          content: _descriptioncontroller.text);
                    }
                  },
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  maxLines: null,
                  controller: _titlecontroller,
                  style: GoogleFonts.robotoSlab(fontSize: 25),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                ),

                // note
                SizedBox(
                  height: mq.height,
                  child: TextField(
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    onChanged: (value) async {
                      // to update the note
                      if (widget.isUpdate == true) {
                        log('update');
                        APIs.updateNote(
                            noteID: widget.notes!.noteID,
                            title: _titlecontroller.text,
                            content: _descriptioncontroller.text);
                      }
                      // // add a new note
                      else if (widget.isUpdate == false &&
                          _descriptioncontroller.text.isNotEmpty &&
                          _descriptioncontroller.text.trim().isNotEmpty &&
                          widget.timeID != null) {
                        //  timeID = DateTime.now().millisecondsSinceEpoch;

                        log('add');
                        await APIs.addNote(
                            timeID: widget.timeID!,
                            tital: _titlecontroller.text,
                            content: _descriptioncontroller.text);
                      }
                    },
                    expands: true,
                    controller: _descriptioncontroller,
                    maxLines: null,
                    autofocus: widget.notes != null ? false : true,
                    //  focusNode: _descriptionFocusNode,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Something Here',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     if (_descriptioncontroller.text.isNotEmpty &&
      //         _descriptioncontroller.text.trim().isNotEmpty) {
      //     } else {
      //       helper.showToastMessage("Please fill all the fiels proparly");
      //     }
      //   },
      //   backgroundColor: Colors.blueGrey,
      //   elevation: 10,
      //   child: const Icon(
      //     Icons.save,
      //     color: Colors.white,
      //     size: 25,
      //   ),
      // ),
    );
  }
}
