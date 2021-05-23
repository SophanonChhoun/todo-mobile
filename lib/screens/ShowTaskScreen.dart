import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/models/Task.dart';
import 'package:todo_app/repos/CategoryRepository.dart';
import 'package:todo_app/repos/TaskRepository.dart';
import 'package:todo_app/screens/CreateTaskScreen.dart';
import 'package:todo_app/screens/HomeScreen.dart';

class ShowTaskScreen extends StatefulWidget {
  final String id;
  final int colorNum;
  final String title;

  const ShowTaskScreen({Key key, this.id, this.colorNum, this.title})
      : super(key: key);

  @override
  _ShowTaskScreenState createState() => _ShowTaskScreenState();
}

class _ShowTaskScreenState extends State<ShowTaskScreen> {
  @override
  var height;
  var width;
  List<Color> colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.grey,
    Colors.black,
    Colors.amber,
  ];
  Future _data;
  TaskRepo _taskRepo = new TaskRepo();
  CategoryRepo _categoryRepo = new CategoryRepo();
  List<Task> _tasks;
  int tasksNum = 0;

  initState() {
    super.initState();
    _data = _taskRepo.readTasks(this.widget.id);
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: CreateTaskScreen(
                id: this.widget.id,
                colorNum: this.widget.colorNum,
                title: this.widget.title,
              ),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
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
                        child: HomeScreen(),
                        type: PageTransitionType.leftToRight,
                      ),
                    );
                  },
                  icon: Icon(Icons.navigate_before),
                  color: Colors.black,
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  icon: Icon(Icons.settings),
                  color: Colors.black,
                  iconSize: 50,
                ),
              ],
            ),
            SizedBox(
              height: height / 22,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: width / 10,
                  height: width / 5.5,
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
                Text(
                  "${this.widget.title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width / 10,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Let's do our work.",
                style: TextStyle(fontSize: width / 20),
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
          _tasks = snapshot.data;

          return _buildTasks();
        } else {
          return _buildWaitingTask();
        }
      },
    );
  }

  _buildTasks() {
    return Expanded(
      child: ListView.builder(
        itemCount: _tasks.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return position == 0
              ? Slidable(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () async {
                        bool updateStatus = await _taskRepo.updateTaskStatus(
                            _tasks[position].id, !_tasks[position].status);
                        if (updateStatus) {
                          final snackBar = SnackBar(
                            content: Text(!_tasks[position].status
                                ? 'Congratulation!!! Another task on the way.'
                                : "Let's do it again."),
                            backgroundColor: Color(0xFF02C39A),
                            action: SnackBarAction(
                              label: 'Okay',
                              onPressed: () {},
                            ),
                          );
                          setState(() {
                            _data = _taskRepo.readTasks(this.widget.id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            content: Text(
                                'Sorry! There is something wrong with updating your task.'),
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
                      },
                      icon: Icon(
                        _tasks[position].status ? Icons.check : Icons.close,
                        color: _tasks[position].status
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    title: Text(
                      _tasks[position].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _tasks[position].status
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ),
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () async {
                        bool taskDeleted =
                            await _taskRepo.deleteTask(_tasks[position].id);
                        if (taskDeleted) {
                          final snackBar = SnackBar(
                            content: Text("Task deleted."),
                            backgroundColor: Color(0xFF02C39A),
                            action: SnackBarAction(
                              label: 'Okay',
                              onPressed: () {},
                            ),
                          );
                          setState(() {
                            _data = _taskRepo.readTasks(this.widget.id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            content: Text(
                                'Sorry! There is something wrong with deleting your task.'),
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
                      },
                    ),
                  ],
                  actionPane: SlidableDrawerActionPane(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 2,
                    ),
                    Slidable(
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () async {
                            bool updateStatus =
                                await _taskRepo.updateTaskStatus(
                                    _tasks[position].id,
                                    !_tasks[position].status);
                            if (updateStatus) {
                              final snackBar = SnackBar(
                                content: Text(!_tasks[position].status
                                    ? 'Congratulation!!! Another task on the way.'
                                    : "Let's do it again."),
                                backgroundColor: Color(0xFF02C39A),
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {},
                                ),
                              );
                              setState(() {
                                _data = _taskRepo.readTasks(this.widget.id);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                content: Text(
                                    'Sorry! There is something wrong with updating your task.'),
                                backgroundColor: Colors.red,
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          icon: Icon(
                            _tasks[position].status ? Icons.check : Icons.close,
                            color: _tasks[position].status
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        title: Text(
                          _tasks[position].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _tasks[position].status
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            bool taskDeleted =
                                await _taskRepo.deleteTask(_tasks[position].id);
                            if (taskDeleted) {
                              final snackBar = SnackBar(
                                content: Text("Task deleted."),
                                backgroundColor: Color(0xFF02C39A),
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {},
                                ),
                              );
                              setState(() {
                                _data = _taskRepo.readTasks(this.widget.id);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                content: Text(
                                    'Sorry! There is something wrong with deleting your task.'),
                                backgroundColor: Colors.red,
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      ],
                      actionPane: SlidableDrawerActionPane(),
                    )
                  ],
                );
        },
      ),
    );
  }

  _buildWaitingTask() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return position == 0
              ? ListTile(
                  leading: IconButton(
                    onPressed: () {
                      // bool status = !tasks[position].done;
                      // user.categories[this.widget.categoryNumber]
                      //     .updateTaskStatus(status, position);
                      setState(() {
                        // tasks = user
                        //     .categories[this.widget.categoryNumber]
                        //     .tasks;
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.grey,
                    ),
                  ),
                  title: Text(
                    "Your tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 2,
                    ),
                    ListTile(
                      leading: IconButton(
                        onPressed: () {
                          // bool status = !tasks[position].done;
                          // user.categories[this.widget.categoryNumber]
                          //     .updateTaskStatus(status, position);
                          setState(() {
                            // tasks = user
                            //     .categories[this.widget.categoryNumber]
                            //     .tasks;
                          });
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                      ),
                      title: Text(
                        "Your tasks",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      color: Colors.white,
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      color: Colors.red,
      onPressed: () async {
        bool categoryDeleted =
            await _categoryRepo.deletedCategory(this.widget.id);
        if (categoryDeleted) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: HomeScreen(),
              type: PageTransitionType.leftToRight,
            ),
          );
        } else {
          final snackBar = SnackBar(
            content: Text(
                'Sorry! There is something wrong with deleting your task.'),
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
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning!!!!!"),
      content: Text("Do you want to delete this?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
