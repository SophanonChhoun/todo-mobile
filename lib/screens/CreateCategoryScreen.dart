import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/model/User.dart';
import 'package:todo_app/repos/CategoryRepository.dart';
import 'package:todo_app/screens/HomeScreen.dart';

class CreateCategoryScreen extends StatefulWidget {
  @override
  _CreateCategoryScreenState createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  var height;
  var width;
  TextEditingController emailController = new TextEditingController();
  bool hasText = false;
  final List<Color> colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.grey,
    Colors.black,
    Colors.amber,
  ];
  CategoryRepo _categoryRepo = new CategoryRepo();

  int selectedColor = 0;

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
                          child: HomeScreen(),
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
                      bool addedCategory = await _categoryRepo.createCategory(
                          emailController.text, selectedColor);
                      if (addedCategory) {
                        final snackBar = SnackBar(
                          content: Text(
                              'Yay! Your new work already added. Break your leg!'),
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
                              'Sorry! There is something with adding your work.'),
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
                SizedBox(
                  width: width / 8,
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
                    onChanged: (text) {
                      setState(() {
                        hasText = emailController.text != '';
                      });
                    },
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: width / 10),
              child: Wrap(
                runSpacing: 20,
                spacing: 10,
                children: List.generate(colors.length, (index) {
                  return selectedColor == index
                      ? Container(
                          width: width / 8,
                          height: width / 8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors[selectedColor]),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              selectedColor = index;
                            });
                          },
                          child: Container(
                            width: width / 8,
                            height: width / 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colors[index],
                                width: 5,
                              ),
                            ),
                          ),
                        );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
