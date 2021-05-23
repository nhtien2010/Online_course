import 'package:bidirectional_listview/bidirectional_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:online_course/model/CourseModel.dart';
import 'package:online_course/model/UserModel.dart';
import 'package:online_course/util/AppConstant.dart';
import 'package:online_course/util/AppUtil.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../ClientHandler.dart';
import '../../RatingStar.dart';
import '../../config.dart';
import 'LoginPage.dart';

class CourseListPage extends StatefulWidget {
  CourseListPage(
      {Key key,
      @required this.pageName,
      @required this.listCourse,
      @required this.count,
      @required this.page})
      : super(key: key);

  String pageName;
  List<CourseModel> listCourse;
  int count;
  int page;

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  ScrollController controller = ScrollController();

  // ScrollController sss = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller = new ScrollController()..addListener(_scrollListener);

    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            widget.pageName,
            style: LightLabelStyle,
          ),
        ),
        body: _courseList());
    // body: AnnotatedRegion<SystemUiOverlayStyle>(
    //     value: SystemUiOverlayStyle.light,
    //     child: GestureDetector(
    //         onTap: () => FocusScope.of(context).unfocus(),
    //         child: Stack(children: <Widget>[
    //           Container(
    //               height: double.infinity,
    //               width: double.infinity,
    //               color: ColorsConfig().lightGrey),
    //           Container(
    //               height: double.infinity,
    //               child: SingleChildScrollView(
    //                 physics: AlwaysScrollableScrollPhysics(),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[_courseList()],
    //                 ),
    //               )),
    //         ]))));
  }

  _courseList() {
    return new Padding(
        padding: EdgeInsets.all(5),
        child: new Container(
            height: double.infinity,
            child: new Padding(
                padding: EdgeInsets.all(2),
                child: new Scrollbar(
                  child: new ListView.builder(
                    controller: controller,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      print(index);
                      CourseModel c = widget.listCourse.elementAt(index);
                      return new Column(
                        children: [
                          _courseItem(c),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      );
                    },
                    itemCount: widget.listCourse.length,
                  ),
                )

                //   SingleChildScrollView(
                //     // scrollDirection: Axis.vertical,
                //     physics: AlwaysScrollableScrollPhysics(),
                //     // controller: controller,
                //     child: Column(
                //       children: [
                //         for (CourseModel c in widget.listCourse)
                //           Column(
                //             children: [
                //               _courseItem(c),
                //               SizedBox(
                //                 height: 8,
                //               )
                //             ],
                //           )
                //       ],
                //     ) ,
                //   )
                // ;

                //         ListView(
                //           // scrollDirection: Axis.vertical,
                //           physics: AlwaysScrollableScrollPhysics(),
                //           controller: controller,
                //           children: [
                //             for (CourseModel c in widget.listCourse)
                //               Column(
                //                 children: [
                //                   _courseItem(c),
                //                   SizedBox(
                //                     height: 8,
                //                   )
                //                 ],
                //               )
                //           ],
                //         )
                // ;
                )));
  }

  _courseItem(CourseModel c) {
    return Container(
      // height: double.infinity,
      // width: 220,
      decoration: LightBoxDecorationStyle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: c.imageUrl,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                height: 90,
                width: 100,
              )),
          SizedBox(
            width: 3,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4),
                  child: Text(
                    c.title,
                    overflow: TextOverflow.ellipsis,
                    style: LightLabelStyle,
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4),
                  child: Text(
                    c.instructor.name,
                    overflow: TextOverflow.ellipsis,
                    style: LightLabelStyle,
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppUtil().hourFormat(c.totalHours),
                          style: LightLabelStyle
                          // TextStyle(
                          //   //color: Colors.black,
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w300),
                          ),
                      SizedBox(width: 18),
                      Text(
                        DateFormat('yyyy MM dd').format(c.updatedAt),
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
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconTheme(
                        data: IconThemeData(color: Colors.amber, size: 12),
                        child: RatingStar(value: c.ratedNumber),
                      ),
                      SizedBox(width: 18),
                      Text(c.price == 0 ? 'Free' : c.price.toString() + ' VND',
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
          ),

          // SizedBox(width: 3,),
          //
          // Align(child:Icon(Icons.more_horiz) ,
          //   alignment: Alignment.topRight,)
        ],
      ),
    );
  }

  _scrollListener() async {
    if (controller.position.extentAfter >= widget.page * 10) {
      List<CourseModel> list = new List();
      var res;

      if (widget.pageName == AppConstant.NEWEST_PAGE) {
        res = await ClientHandler().listTopNewCourse(10, ++widget.page);
      }
      if (widget.pageName == AppConstant.TOP_SELL_PAGE) {
        res = await ClientHandler().listTopSellCourse(10, ++widget.page);
      }
      if (widget.pageName == AppConstant.SUGGEST_PAGE) {
        res = await ClientHandler().listSuggestCourse(UserInfo().model.id ,10, ++widget.page);
      }

      if (res.item1 == 200) {
        var data = res.item2["payload"];
        for (var item in data) {
          CourseModel c = CourseModel.fromJson(item);
          list.add(c);
        }
      }
      setState(() {
        widget.listCourse.addAll(list);
      });
    }
  }
}
