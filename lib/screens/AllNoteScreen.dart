import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/models/Note.dart';
import 'package:todo_app/repos/NoteRepository.dart';
import 'package:todo_app/screens/CreateNoteScreen.dart';
import 'package:todo_app/screens/EditNoteScreen.dart';
import 'package:todo_app/screens/Test.dart';

class MyNotesView extends StatefulWidget {
  @override
  _MyNotesViewState createState() => _MyNotesViewState();
}

class _MyNotesViewState extends State<MyNotesView> {
  final _noteRepo = new NoteRepo();
  List<Note> notes;
  Future _data;
  var height;
  var width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = _noteRepo.readAllNote();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final _theme = Theme.of(context);
    return Scaffold(
      body: _buildBody,
      floatingActionButton: FancyFab(),
    );
  }

  get _buildBody {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        color: Colors.grey.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(PageTransition(
                  child: CreateNoteScreen(),
                  type: PageTransitionType.leftToRight,
                ));
              },
              icon: Icon(Icons.add),
              color: Colors.black,
              iconSize: 50,
            ),
            SizedBox(
              height: height / 22,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Notes",
                style: TextStyle(fontSize: width / 10),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 2,
            ),
            _buildView(),
          ],
        ),
      ),
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
          notes = snapshot.data;
          return _buildNotes();
        } else {
          return _buildWaitingNotes();
        }
      },
    );
  }

  _buildNotes() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: notes.length,
        separatorBuilder: (context, index) => Divider(
              thickness: 2,
            ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notes[index].content.length < 30
                ? notes[index].content
                : (notes[index].content.substring(0, 30) + "...")),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushReplacement(PageTransition(
                child: EditNoteScreen(
                  id: notes[index].id,
                ),
                type: PageTransitionType.leftToRight,
              ));
            },
          );
        });
  }

  _buildWaitingNotes() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (context, index) => Divider(
              thickness: 2,
            ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(""),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          );
        });
  }
}
