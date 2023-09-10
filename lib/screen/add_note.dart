import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_note/api/apis.dart';
import 'package:lets_note/helper/helper.dart';
import 'package:lets_note/main.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
  });
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _descriptioncontroller = TextEditingController();
  final _titlecontroller = TextEditingController();
  //final _descriptionFocusNode = FocusNode();

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //
  //   _descriptionFocusNode.dispose();
  // }

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.black38,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        // GestureDetector
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            //         FocusScope.of(context).requestFocus(_descriptionFocusNode);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              // for tital and note
              child: Column(
                children: [
                  // tital
                  TextField(
                    controller: _titlecontroller,
                    style: GoogleFonts.robotoSlab(fontSize: 30),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(fontSize: 30, color: Colors.grey),
                    ),
                  ),

                  // note
                  SizedBox(
                    height: mq.height,
                    child: TextField(
                      expands: true,
                      controller: _descriptioncontroller,
                      maxLines: null,
                      autofocus: true,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_descriptioncontroller.text.isNotEmpty &&
              _descriptioncontroller.text.trim().isNotEmpty) {
            await APIs.addNote(
                    _titlecontroller.text, _descriptioncontroller.text)
                .then(
              (value) {
                _titlecontroller.clear();
                _descriptioncontroller.clear();
                Navigator.of(context).pop();
              },
            );
          } else {
            helper.showToastMessage("Please fill all the fiels proparly");
          }
        },
        backgroundColor: Colors.blueGrey,
        elevation: 10,
        child: const Icon(
          Icons.save,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
