import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RatingStar.dart';

class CourseListPage extends StatefulWidget {
  CourseListPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: _courseList(),
      ),
    );
  }

  _courseList() {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Container(
            height: 500,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                children: [
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),
                  _courseItem(
                      "assets/images/1.png",
                      'Course title name',
                      'Tien Nguyen',
                      'Beginer',
                      'Jun 2021',
                      '4h',
                      4.5,
                      100),
                  SizedBox(height: 10),


                ],
              ),
            )
        )
    );
  }

  _courseItem(String asset, String name, String author, String level,
      String date, String time, double rate, int view) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        //borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            //borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              asset,
              alignment: Alignment.topLeft,
              fit: BoxFit.cover,
              height: 70,
              width: 80,
            ),
          ),
          SizedBox(width: 3,),
          Flexible(child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    //color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  author,
                  style: TextStyle(
                    //color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w200),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      level,
                      style: TextStyle(
                        //color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 8),
                    Text('.'),
                    SizedBox(width: 8),
                    Text(
                      date,
                      style: TextStyle(
                        //color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 8),
                    Text('.'),
                    SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        //color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTheme(
                      data: IconThemeData(color: Colors.amber, size: 12),
                      child: RatingStar(value: rate.toInt()),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '(' + view.toString() + ')',
                      style: TextStyle(
                        //color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )
            ],
          ), ),

          SizedBox(width: 3,),

          Align(child:Icon(Icons.more_horiz) ,
          alignment: Alignment.topRight,)

        ],
      ),
    );
  }
}
