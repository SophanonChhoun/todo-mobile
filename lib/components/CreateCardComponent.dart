import 'package:flutter/material.dart';

class CreateCardComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(width / 50),
          width: width / 2.8,
          height: height / 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 48,
                  ),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Create",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
