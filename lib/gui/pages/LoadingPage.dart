import 'package:online_course/config.dart';
import 'package:online_course/util/AppUtil.dart';

import '../../ClientHandler.dart';
import '../../main.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'package:online_course/theme/box_icons_icons.dart';
import 'package:online_course/gui/menus/menu_dashboard_layout.dart';
import 'package:flutter/cupertino.dart';

class OnLoading extends StatefulWidget {
  @override
  _OnloadingState createState() => _OnloadingState();
}

class _OnloadingState extends State<OnLoading> {
  final PageController controller = PageController(initialPage: 0);
  int pageNumber;
  List widgets = [];

  @override
  void initState() {
    pageNumber = 0;
    super.initState();


  }

  void createWidgets() {
    widgets.addAll([
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/0.png'),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              "OnLearning",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  color: Color(0xFFFFFFFF)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          CupertinoButton(
              color: Color(0xFFFFFFFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Let's roll",
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        color: ColorsConfig().secondColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => LoginPage()));
              })
        ],
      ),
    ]);


  }

  @override
  Widget build(BuildContext context) {
    createWidgets();
    if (localStorage != null &&
        localStorage.getString("email") != null &&
        localStorage.getString("email").length >0){

      if(localStorage.getString("password") != null &&
          localStorage.getString("password").length>0){
        String email = localStorage.getString("email").toString();
        String password = localStorage.getString("password").toString();
        logIn(context, email, password);
      }
      else if(localStorage.getString("id") != null &&
          localStorage.getString("id").length>0){
        String email = localStorage.getString("email").toString();
        String id = localStorage.getString("id").toString();
        logInGoogle(context, email, id);
      }

    }
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ColorsConfig().lightColors,
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    pageNumber = value;
                  });
                },
                itemCount: 2,
                itemBuilder: (context, index) => widgets[index]),
          ),
          if (pageNumber == 1) Container()
        ],
      ),
    );
  }
}

Future<void> logIn(BuildContext context, String email, String password) async {
  var res = await ClientHandler().logIn(email, password);
  print(res);

  if (res.item1 == 200) {
    saveLogin();
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => HomePage()));
    // AppUtil().showSignUpAlert(context, 'Success', res.item2["message"]+", Đang gửi email xác thực", true);
  } else {
    AppUtil().showAlert(context, 'Oops', res.item2["message"]);
  }
}

Future<void> logInGoogle(BuildContext context, String email, String id) async {
  var res = await ClientHandler().logInGoogle(email, id);
  print(res);

  if (res.item1 == 200) {
    saveGoogleLogin(email, id);
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => HomePage()));
    // AppUtil().showSignUpAlert(context, 'Success', res.item2["message"]+", Đang gửi email xác thực", true);
  } else {
    AppUtil().showAlert(context, 'Oops', res.item2["message"]);
  }
}
