import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/models/User.dart';
import 'package:todo_app/repos/UserRepository.dart';
import 'package:todo_app/screens/EditEmailScreen.dart';
import 'package:todo_app/screens/EditNameScreen.dart';
import 'package:todo_app/screens/EditPasswordScreen.dart';
import 'package:todo_app/screens/Test.dart';

import 'HomeScreen.dart';

class ProfileInfoScreen extends StatefulWidget {
  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  var width;
  var height;
  Future _data;
  UserRepo _userRepo = new UserRepo();
  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = _userRepo.readUsers();
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _buildBody,
      floatingActionButton: FancyFab(),
    );
  }

  get _buildBody {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: width / 10,
          ),
          _buildView(),
        ],
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
          _user = snapshot.data;
          return _buildProfile();
        } else {
          return _buildWaitingProfile();
        }
      },
    );
  }

  _buildProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: EditNameScreen(
                      name: _user.name,
                      email: _user.email,
                    ),
                    type: PageTransitionType.rightToLeft,
                  ),
                ).then((value) => {
                      this.setState(() {
                        _data = _userRepo.readUsers();
                      })
                    });
              },
              child: Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.pink.withOpacity(0.8),
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: EditNameScreen(
                                  name: _user.name,
                                  email: _user.email,
                                ),
                                type: PageTransitionType.rightToLeft,
                              ),
                            ).then((value) => {
                                  this.setState(() {
                                    _data = _userRepo.readUsers();
                                  })
                                });
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        "${_user.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: EditEmailScreen(
                      name: _user.name,
                      email: _user.email,
                    ),
                    type: PageTransitionType.rightToLeft,
                  ),
                ).then((value) => {
                      this.setState(() {
                        _data = _userRepo.readUsers();
                      })
                    });
              },
              child: Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.pink.withOpacity(0.8),
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: EditEmailScreen(
                                  name: _user.name,
                                  email: _user.email,
                                ),
                                type: PageTransitionType.rightToLeft,
                              ),
                            ).then((value) => {
                                  this.setState(() {
                                    _data = _userRepo.readUsers();
                                  })
                                });
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        "${_user.email}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: EditPasswordScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                ).then((value) => {
                      this.setState(() {
                        _data = _userRepo.readUsers();
                      })
                    });
              },
              child: Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.pink.withOpacity(0.8),
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: EditPasswordScreen(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            ).then((value) => {
                                  this.setState(() {
                                    _data = _userRepo.readUsers();
                                  })
                                });
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        "*******",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildWaitingProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.pink.withOpacity(0.8),
                          size: 25,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.pink.withOpacity(0.8),
                          size: 25,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.pink.withOpacity(0.8),
                          size: 25,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
