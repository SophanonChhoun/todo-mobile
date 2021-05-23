import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/model/User.dart';
import 'package:todo_app/repos/TaskRepository.dart';
import 'package:todo_app/screens/ShowTaskScreen.dart';

class CreateTaskScreen extends StatefulWidget {
  final String id;
  final String title;
  final int colorNum;

  const CreateTaskScreen({Key key, this.id, this.title, this.colorNum})
      : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  var height;
  var width;
  bool hasText = false;
  TextEditingController emailController = new TextEditingController();
  List<Color> colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.grey,
    Colors.black,
    Colors.amber,
  ];
  TaskRepo _taskRepo = new TaskRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _buildBody,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: ShowTaskScreen(
                            id: this.widget.id,
                            title: this.widget.title,
                            colorNum: this.widget.colorNum,
                          ),
                          type: PageTransitionType.leftToRight,
                        ));
                  },
                  icon: Icon(Icons.close),
                  color: Colors.black,
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () async {
                    if (hasText) {
                      bool addedTask = await _taskRepo.createTask(
                          emailController.text, this.widget.id);
                      if (addedTask) {
                        final snackBar = SnackBar(
                          content: Text(
                              'Yay! Your new task already added. Break your leg!'),
                          backgroundColor: Color(0xFF02C39A),
                          action: SnackBarAction(
                            label: 'Okay',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: Text(
                              'Sorry! There is something wrong with adding your task.'),
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
                  icon: Icon(Icons.check),
                  color: hasText ? Colors.black : Colors.grey,
                  iconSize: 50,
                ),
              ],
            ),
            SizedBox(
              height: height / 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 13),
                  width: width / 10,
                  height: width / 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors[this.widget.colorNum],
                      width: 10,
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 20,
                ),
                Container(
                  width: width - (width / 10) - 100,
                  child: TextField(
                    controller: emailController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Type Anything here!!',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    onChanged: (text) {
                      setState(() {
                        hasText = emailController.text != '';
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
