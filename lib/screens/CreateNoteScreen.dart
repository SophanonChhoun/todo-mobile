import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/repos/NoteRepository.dart';
import 'package:todo_app/screens/AllNoteScreen.dart';

class CreateNoteScreen extends StatefulWidget {
  final bool autoFocus;
  CreateNoteScreen({
    this.autoFocus = true,
  });
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final _textFieldController = TextEditingController();
  NoteRepo _noteRepo = new NoteRepo();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            if (_textFieldController.text != '') {
              bool noteCreated =
                  await _noteRepo.createNotes(_textFieldController.text);
              if (noteCreated) {
                Navigator.of(context).pushReplacement(PageTransition(
                  child: MyNotesView(),
                  type: PageTransitionType.leftToRight,
                ));
              } else {
                final snackBar = SnackBar(
                  content: Text(
                      'Sorry! There is something wrong with saving your note.'),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'Okay',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              Navigator.of(context).pushReplacement(PageTransition(
                child: MyNotesView(),
                type: PageTransitionType.leftToRight,
              ));
            }
          },
          icon: Icon(Icons.close),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Notes",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: TextFormField(
        controller: _textFieldController,
        autofocus: widget.autoFocus,
        maxLines: null,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.only(top: 8, left: 24, bottom: 24, right: 24),
            hintText: "Your notes start here..."),
      ),
    );
  }
}
