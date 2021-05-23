import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_course/config.dart';
import 'package:online_course/gui/pages/SignUpPage.dart';
import 'package:online_course/main.dart';
import 'package:online_course/util/AppUtil.dart';

import '../../ClientHandler.dart';
import 'HomePage.dart';
import 'forgetPasswordPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class _LoginPageState extends State<LoginPage> {
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

  Future<void> logIn() async {
    print("LOGIN BUTTON PRESSED");
    var res = await ClientHandler().logIn(email.text, password.text);
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

  Future<void> loginGoogle() async {
    print("LOGIN GOOGLE BUTTON PRESSED");
    var res = await ClientHandler().logInGoogle(null, null);
    print(res);

    if (res.item1 == 200) {
      saveGoogleLogin(res.item2["userInfo"]["email"], res.item3);
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context) => HomePage()));
      // AppUtil().showSignUpAlert(context, 'Success', res.item2["message"]+", Đang gửi email xác thực", true);
    } else {
      AppUtil().showAlert(context, 'Oops', res.item2["message"]);
    }
  }

  Future<void> forgetPassword() async {
    print("FORGET PASSWORD PRESSED");
    var res = await ClientHandler().logIn(email.text, password.text);
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: LightLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: LightBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: LightHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: LightLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: LightBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: password,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: LightHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ForgetPassPage())),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: LightLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: logIn,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[

        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: LightLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            loginGoogle,
            AssetImage(
              'assets/images/google.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => SignUpPage(),
        ),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final LightHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final LightBoldLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final LightBigLabelStyle = TextStyle(
  color: ColorsConfig().accentColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
    fontSize: 20
);

final BlueLabelStyle = TextStyle(
  color: ColorsConfig().accentColor,
  fontFamily: 'OpenSans',
);

final LightLabelStyle = TextStyle(
  color: ColorsConfig().white,
  fontFamily: 'OpenSans',

);

final LightBoxDecorationStyle = BoxDecoration(
  color: ColorsConfig().accentColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

void saveLogin()async{
  await MyApp.init();
  localStorage.setString('email', email.text.toString());
  localStorage.setString('password', password.text.toString());
  // localStorage.setString('token', value);
}

void saveGoogleLogin(String email, String id)async{
  await MyApp.init();
  localStorage.setString('email', email);
  localStorage.setString('id', id);
  // localStorage.setString('token', value);
}

