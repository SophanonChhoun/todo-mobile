import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/components/CardComponent.dart';
import 'package:todo_app/components/CreateCardComponent.dart';
import 'package:todo_app/model/User.dart';
import 'package:todo_app/models/Category.dart';
import 'package:todo_app/repos/CategoryRepository.dart';
import 'package:todo_app/screens/CreateCategoryScreen.dart';
import 'package:todo_app/screens/ShowTaskScreen.dart';

import 'Test.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var width;
  var height;
  int numberOfUserCategory;
  int numberOfCategory;
  Future _data;
  CategoryRepo _categoryRepo = new CategoryRepo();
  List<Category> _categories;

  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = _categoryRepo.readCategory();
  }

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    numberOfUserCategory = user.categories != null ? user.categories.length : 0;
    numberOfCategory = numberOfUserCategory + 1;
    return Scaffold(
      body: _buildBody,
      floatingActionButton: FancyFab(),
    );
  }

  get _buildBody {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(left: width / 6, top: height / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Let's create!!!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildView(),
            ],
          ),
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
          _categories = snapshot.data;
          numberOfCategory = _categories.length;
          return _buildCategories();
        } else {
          return _buildWaitingCategories();
        }
      },
    );
  }

  _buildCategories() {
    return Wrap(
      runSpacing: 20,
      spacing: 10,
      children: List.generate(numberOfCategory + 1, (index) {
        if (index == numberOfCategory) {
          return InkWell(
            child: CreateCardComponent(),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: CreateCategoryScreen(),
                    type: PageTransitionType.rightToLeft,
                  ));
            },
          );
        } else {
          return InkWell(
            child: CardComponent(
              title: _categories[index].title,
              colorNum: _categories[index].colorNum,
              taskNumber: 2,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: ShowTaskScreen(
                    id: _categories[index].id,
                    colorNum: _categories[index].colorNum,
                    title: _categories[index].title,
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
          );
        }
      }),
    );
  }

  _buildWaitingCategories() {
    return Wrap(
        runSpacing: 20,
        spacing: 10,
        children: List.generate(5, (index) {
          return Container(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.all(width / 21),
                width: width / 2.8,
                height: height / 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: width / 19,
                        height: width / 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.teal,
                            width: 5,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's do it.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          "Please Wait",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
