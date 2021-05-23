import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final String title;
  final int colorNum;
  final int taskNumber;

  const CardComponent({Key key, this.title, this.colorNum, this.taskNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<Color> colors = <Color>[
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.blue,
      Colors.grey,
      Colors.black,
      Colors.amber,
    ];
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
                      color: colors[this.colorNum],
                      width: 5,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${this.title.length < 10 ? this.title : (this.title.substring(0, 10) + " ...")}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    "Tap Here",
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
  }
}
