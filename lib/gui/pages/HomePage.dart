import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:online_course/ClientHandler.dart';
import 'package:online_course/util/AppConstant.dart';
import 'CourseListPage.dart';
import 'package:online_course/DownloadListPage.dart';
import 'SearchPage.dart';
import 'package:online_course/gui/pages/LoginPage.dart';
import 'package:online_course/model/CourseModel.dart';
import 'package:online_course/model/InstructorModel.dart';
import 'package:online_course/model/UserModel.dart';
import 'package:online_course/util/AppUtil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../RatingStar.dart';
import '../../config.dart';
import 'BrowsePage.dart';
import 'overlay.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();

// HomePage();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  Color courseCardColor = ColorsConfig().accentColor;

  int tabNum = 0;
  bool overlayVisible;
  CupertinoTabController controller;

  @override
  void initState() {
    overlayVisible = false;
    controller = CupertinoTabController(initialIndex: 0);
    super.initState();

    // ClientHandler().updateUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    int _currentTab = 0;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CupertinoTabScaffold(
          // appBar: AppBar(
          //   // Here we take the value from the MyHomePage object that was created by
          //   // the App.build method, and use it to set our appbar title.
          //   //title: Text(widget.title),
          // ),
          controller: controller,
          tabBar: CupertinoTabBar(
            onTap: (value) {
              setState(() {
                tabNum = value;
              });
            },
            // bottomNavigationBar: BottomNavigationBar(
            activeColor: ColorsConfig().accentColor,
            inactiveColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: tabNum == 0 ? Text("Home") : Container()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_circle_down),
                  title: tabNum == 1 ? Text("Download") : Container()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.auto_awesome_motion),
                  title: tabNum == 2 ? Text("Browse") : Container()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: tabNum == 3 ? Text("Search") : Container()),
            ],
          ),
          tabBuilder: (context, index) => (index == 0)
              ? MyHomePage(
                  // onMenuTap: widget.onMenuTap,
                  )
              : (index == 1)
                  ? DownloadListPage(
                      // onMenuTap: widget.onMenuTap,
                      )
                  : (index == 2)
                      ? BrowsePage(
                          // onMenuTap: widget.onMenuTap,
                          )
                      : SearchPage(
                          // onMenuTap: widget.onMenuTap,
                          ),
        ),
        overlayVisible ? OverlayWidget() : Container(),
      ],
    );
  }
}

_authorItem(InstructorModel au
    // String asset, String name
    ) {
  return Container(
      decoration: BoxDecoration(
          //color: Colors.lightBlueAccent,
          ),
      child: Column(
        children: [
          ClipRRect(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: au.userModel.avatar,
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
            borderRadius: BorderRadius.circular(45),
          ),
          SizedBox(
            height: 2,
          ),
          Text(au.userModel.name,
              overflow: TextOverflow.ellipsis, style: BlueLabelStyle
              // TextStyle(
              //   //color: Colors.black,
              //   fontSize: 15,
              //   fontWeight: FontWeight.w300,
              // ),
              )
        ],
      ));
}

_courseItem(CourseModel course
    // String asset, String name, String author, String level, String date,
    // String time, double rate, int view
    ) {
  return Container(
    height: double.infinity,
    width: 220,
    decoration: LightBoxDecorationStyle,
    // BoxDecoration(
    //   color: courseCardColor,
    //   //borderRadius: BorderRadius.circular(20)
    // ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: course.imageUrl,
              fit: BoxFit.cover,
              height: 100,
              width: 220,
            )),
        SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4),
          child: Text(
            course.title,
            overflow: TextOverflow.ellipsis,
            style: LightLabelStyle,
            // TextStyle(
            //   //color: Colors.black,
            //   fontSize: 15,
            //   fontWeight: FontWeight.w300,
            // ),
          ),
        ),
        SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4),
          child: Text(
            course.instructor.name,
            overflow: TextOverflow.ellipsis,
            style: LightLabelStyle,
            // TextStyle(
            //   //color: Colors.black,
            //     fontSize: 12,
            //     fontWeight: FontWeight.w200),
          ),
        ),
        SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppUtil().hourFormat(course.totalHours),
                  style: LightLabelStyle
                  // TextStyle(
                  //   //color: Colors.black,
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w300),
                  ),
              SizedBox(height: 8),
              Text(
                DateFormat('yyyy MM dd').format(course.updatedAt),
                style: LightLabelStyle,
                // TextStyle(
                //   //color: Colors.black,
                //     fontSize: 12,
                //     fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconTheme(
                data: IconThemeData(color: Colors.amber, size: 12),
                child: RatingStar(value: course.ratedNumber),
              ),
              SizedBox(
                height: 4,
                width: 4,
              ),
              Text(
                  course.price == 0 ? 'Free' : course.price.toString() + ' VND',
                  style: LightLabelStyle
                  // TextStyle(
                  //   //color: Colors.black,
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w300),
                  ),
            ],
          ),
        )
      ],
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final onMenuTap;

  MyHomePage({
    Key key,
    @required this.onMenuTap,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  List<CourseModel> topNewCourse = new List();
  List<CourseModel> topSellCourse = new List();
  List<CourseModel> userProcessCourse = new List();
  List<InstructorModel> authors = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: ()=>{print("avatar")},
            child: Container(
              decoration: new BoxDecoration(shape: BoxShape.circle, border: new Border.all(color: ColorsConfig().accentColor, width: 0.7)),
              child:
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: new NetworkImage(
                  // placeholder: "assets/images/user.png",
                  UserInfo().model.avatar,
                  // alignment: Alignment.center,
                  // fit: BoxFit.cover,
                  // height: 60,
                  // width: 60,
                ),
                // child:
                // ,
                // borderRadius: BorderRadius.circular(45),
              ),
            ),
          ),
          IconButton(onPressed: () => {}, icon: Icon(Icons.more_vert)),
          SizedBox(
            width: 10,
          )
        ],
        title: Text(
          "OnLearning",
          style: LightLabelStyle,
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ColorsConfig().lightGrey),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _newCourseList(),
                        _trendingCourseList(),
                        if (userProcessCourse.length > 0) _processCourseList(),
                        _topAuthorList(),
                        Container(
                          height: 50,
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
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
                Text('Newest', style: LightBigLabelStyle
                    // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                Spacer(),
                IconButton(
                  icon: new Icon(Icons.more_horiz),
                  highlightColor: ColorsConfig().accentColor,
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => CourseListPage(
                                listCourse: topNewCourse,
                                pageName: AppConstant.NEWEST_PAGE,
                                count: 0,
                                page: 1,
                              ))),
                )
              ],
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 190,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (CourseModel c in topNewCourse)
                    Row(
                      children: [
                        _courseItem(c),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _processCourseList() {
    return Padding(
      padding: EdgeInsets.only(top: 2),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text('My Courses', style: LightBigLabelStyle
                    // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                Spacer(),
                IconButton(
                  icon: new Icon(Icons.more_horiz),
                  highlightColor: ColorsConfig().accentColor,
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => CourseListPage(
                                listCourse: userProcessCourse,
                                pageName: AppConstant.PROCESS_PAGE,
                                count: 0,
                                page: 1,
                              ))),
                )
              ],
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 190,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (CourseModel c in userProcessCourse)
                    Row(
                      children: [
                        _courseItem(c),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    )
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
                Text('Trending', style: LightBigLabelStyle
                    // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                Spacer(),
                IconButton(
                  icon: new Icon(Icons.more_horiz),
                  highlightColor: ColorsConfig().accentColor,
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => CourseListPage(
                                listCourse: topSellCourse,
                                pageName: AppConstant.TOP_SELL_PAGE,
                                count: 0,
                                page: 1,
                              ))),
                )
              ],
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 190,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (CourseModel c in topSellCourse)
                    Row(
                      children: [
                        _courseItem(c),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    )
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
                  style: LightBigLabelStyle,
                  // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                  for (InstructorModel c in authors)
                    Row(
                      children: [
                        _authorItem(c),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _loadTopNewCourseList(int limit, int page) async {
    var res = await ClientHandler().listTopNewCourse(limit, page);
    if (res.item1 == 200) {
      var data = res.item2["payload"];
      List<CourseModel> list = new List();
      for (var item in data) {
        CourseModel c = CourseModel.fromJson(item);
        list.add(c);
      }
      setState(() {
        topNewCourse = list;
      });
    }
  }

  _loadTopSellCourseList(int limit, int page) async {
    var res = await ClientHandler().listTopSellCourse(limit, page);
    if (res.item1 == 200) {
      var data = res.item2["payload"];
      List<CourseModel> list = new List();
      for (var item in data) {
        CourseModel c = CourseModel.fromJson(item);
        list.add(c);
      }
      setState(() {
        topSellCourse = list;
      });
    }
  }

  _loadUserProcessCourseList(int limit, int page) async {
    var res = await ClientHandler().listUserProcessCourse();
    if (res.item1 == 200) {
      var data = res.item2["payload"];
      List<CourseModel> list = new List();
      for (var item in data) {
        CourseModel c = CourseModel.fromJson(item);
        list.add(c);
      }
      setState(() {
        userProcessCourse = list;
      });
    }
  }

  _loadTopAuthorList(int limit, int page) async {
    var res = await ClientHandler().listAuthor();
    if (res.item1 == 200) {
      var data = res.item2["payload"];
      List<InstructorModel> list = new List();
      for (var item in data) {
        InstructorModel c = InstructorModel.fromJson(item);
        list.add(c);
      }
      setState(() {
        authors = list;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTopNewCourseList(10, 1);
    _loadTopSellCourseList(10, 1);
    _loadUserProcessCourseList(10, 1);
    _loadTopAuthorList(10, 1);
  }
}
