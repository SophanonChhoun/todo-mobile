import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/models/Note.dart';
import 'package:todo_app/repos/NoteRepository.dart';
import 'package:todo_app/screens/AllNoteScreen.dart';

class EditNoteScreen extends StatefulWidget {
  final bool autoFocus;
  final String id;
  EditNoteScreen({
    this.autoFocus = true,
    this.id,
  });
  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _textFieldController = TextEditingController();
  NoteRepo _noteRepo = new NoteRepo();
  Future _data;

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = _noteRepo.readNote(this.widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            if (_textFieldController.text != '') {
              bool noteCreated = await _noteRepo.updatedNote(
                  this.widget.id, _textFieldController.text);
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
              bool noteDeleted = await _noteRepo.deletedNote(this.widget.id);
              if (noteDeleted) {
                Navigator.of(context).pushReplacement(PageTransition(
                  child: MyNotesView(),
                  type: PageTransitionType.leftToRight,
                ));
              } else {
                final snackBar = SnackBar(
                  content: Text(
                      'Sorry! There is something wrong. Please try again.'),
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
      body: _buildView(),
    );
  }

  _buildView() {
    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          _textFieldController.text = snapshot.data.content;
          return _buildTextField();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _buildTextField() {
    return TextFormField(
      controller: _textFieldController,
      autofocus: widget.autoFocus,
      maxLines: null,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.only(top: 8, left: 24, bottom: 24, right: 24),
          hintText: "Your notes start here..."),
    );
  }
}
