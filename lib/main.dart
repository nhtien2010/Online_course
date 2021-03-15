import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_course/CourseListPage.dart';
import 'package:online_course/DownloadListPage.dart';
import 'package:online_course/ForgetPasswordPage.dart';
import 'package:online_course/LoginPage.dart';
import 'package:online_course/SearchPage.dart';
import 'package:online_course/SplashPage.dart';
import 'RatingStar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online course App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Online Courses Home page'),
      //home: CourseListPage(title: 'Online Courses'),
      //home: DownloadListPage(title: 'Downloads Courses'),
      //home: SearchPage(title: ''),
      //home: LoginPage(title: ''),
     // home: ForgetPasswordPage(title: ''),
      //home: SplashPage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    int _currentTab = 0;

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: [_newCourseList(), _trendingCourseList(), _topAuthorList()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_down),
                title: Text('Downloads'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome_motion),
                title: Text('Browse'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
                backgroundColor: Colors.blue),
          ],
        ));
  }

  _newCourseList() {
    return Padding(
      padding: EdgeInsets.only(top: 2),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  'New',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Icon(Icons.more_horiz)
              ],
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 160,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  _courseItem("assets/images/1.png", 'Course title name',
                      'Tien Nguyen', 'Beginer', 'Jun 2021', '4h', 4.5, 100),
                  SizedBox(width: 10),
                  _courseItem("assets/images/1.png", 'Course title name',
                      'Tien Nguyen', 'Beginer', 'Jun 2021', '4h', 4.5, 100),
                  SizedBox(width: 10),
                  _courseItem("assets/images/1.png", 'Course title name',
                      'Tien Nguyen', 'Beginer', 'Jun 2021', '4h', 4.5, 100)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _trendingCourseList() {
    return Padding(
      padding: EdgeInsets.only(top: 2),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  'Trending',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Icon(Icons.more_horiz)
              ],
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 160,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  _courseItem("assets/images/1.png", 'Course title name',
                      'Tien Nguyen', 'Beginer', 'Jun 2021', '4h', 4.5, 100),
                  SizedBox(width: 10),
                  _courseItem("assets/images/1.png", 'Course title name',
                      'Tien Nguyen', 'Beginer', 'Jun 2021', '4h', 4.5, 100),
                  SizedBox(width: 10),
                  _courseItem("assets/images/1.png", 'Course title name',
                      'Tien Nguyen', 'Beginer', 'Jun 2021', '4h', 4.5, 100)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _topAuthorList() {
    return Padding(
      padding: EdgeInsets.only(top: 2),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  'Top Authors',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                //Spacer(),
                //Icon(Icons.more_horiz)
              ],
            ),
          ),
          SizedBox(height: 2),
          Container(
            //color: Colors.grey,
            height: 110,
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 2),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  _authorItem("assets/images/2.jpg", "Emma .."),
                  SizedBox(width: 10,),
                  _authorItem("assets/images/2.jpg", "Emma .."),
                  SizedBox(width: 10,),
                  _authorItem("assets/images/2.jpg", "Emma .."),
                  SizedBox(width: 10,),
                  _authorItem("assets/images/2.jpg", "Emma .."),
                  SizedBox(width: 10,),
                  _authorItem("assets/images/2.jpg", "Emma .."),
                  SizedBox(width: 10,),
                  _authorItem("assets/images/2.jpg", "Emma .."),
                  SizedBox(width: 10,),
                  _authorItem("assets/images/2.jpg", "Emma .."),
                  SizedBox(width: 10,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _authorItem(String asset, String name) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.lightBlueAccent,
      ),
        child: Column(
      children: [
        ClipRRect(
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
            height: 80,
            width: 80,
          ),
          borderRadius: BorderRadius.circular(45),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          name,
          style: TextStyle(
            //color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    ));
  }

  _courseItem(String asset, String name, String author, String level,
      String date, String time, double rate, int view) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        //borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            //borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              asset,
              fit: BoxFit.cover,
              height: 90,
              width: 200,
            ),
          ),
          SizedBox(height: 2),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  level,
                  style: TextStyle(
                      //color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 8),
                Text('.'),
                SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(
                      //color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 8),
                Text('.'),
                SizedBox(height: 8),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTheme(
                  data: IconThemeData(color: Colors.amber, size: 12),
                  child: RatingStar(value: rate.toInt()),
                ),
                SizedBox(height: 8),
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
      ),
    );
  }
}
