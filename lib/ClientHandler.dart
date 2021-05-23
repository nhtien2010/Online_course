import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import 'model/UserModel.dart';

class ClientHandler {
  String apiUrl = 'http://api.letstudy.org/';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  Future<int> updateUserInfo() async {
    try {
      var client = http.Client();

      var res = await client.get(Uri.parse(apiUrl + 'user/me'),
          headers: {
            'accept': 'application/json'
          });

      var data = json.decode(res.body);
      print(data);
      if(res.statusCode == 200){
        UserInfo().model = UserModel.fromJson(data["payload"]);
        UserInfo().token = data["token"];
      }
      return res.statusCode;

    } catch (e) {
      print(e);
      return 404;
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> signUp(
      String name, String email, String password, String phone) async {
    try {
      var client = http.Client();
      UserModel user = new UserModel(
          name: name, email: email, phone: phone, password: password);
      String data = json.encode(user.toJson());

      var res = await client.post(Uri.parse(apiUrl + 'user/register'),
          headers: headers, body: data);

      print(data);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> logIn(
      String email, String password) async {
    try {
      var client = http.Client();
      UserModel user = new UserModel(
          email: email, password: password);
      String data = json.encode(user.toJson());

      var res = await client.post(Uri.parse(apiUrl + 'user/login'),
          headers: headers, body: data);

      print(data);

      if(res.statusCode == 200){
        var data = json.decode(res.body);
        UserInfo().model = UserModel.fromJson(data["userInfo"]);
        UserInfo().token = data["token"];
      }

      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple3<int, Map<String, dynamic>, String>> logInGoogle(String email, String id) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      if(email == null && id == null){
        var res1 = await _googleSignIn.signIn();
        var auth = await res1.authentication;
        // var googleId = auth.idToken;
        id = auth.accessToken;
        email = res1.email;
      }

      var client = http.Client();
      var user = {
        "user":{
          "email":email,
          "id":id
        }
      };
      String data = json.encode(user);

      var res = await client.post(Uri.parse(apiUrl + 'user/login-google-mobile'),
          headers: headers, body: data);

      print(data);


      if(res.statusCode == 200){
        var data = json.decode(res.body);
        UserInfo().model = UserModel.fromJson(data["userInfo"]);
        UserInfo().token = data["token"];
      }
      return Tuple3(res.statusCode, json.decode(res.body), id);

    } catch (e) {
      print(e);
      return Tuple3(404, {"message":"Error not found"}, null);
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> changePassword(
      String id, String oldPass, String newPass) async {
    try {
      var client = http.Client();
      var user = {
        "id": id,
        "oldPass": oldPass,
        "newPass": newPass
      };
      String data = json.encode(user);

      var res = await client.post(Uri.parse(apiUrl + 'user/change-password'),
          headers: headers, body: data);

      print(data);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> forgetPassAndSendEmail(String email) async {
    try {
      var client = http.Client();

      UserModel user = new UserModel(
          email: email);
      String data = json.encode(user.toJson());

      var res = await client.post(Uri.parse(apiUrl + 'user/forget-pass/send-email'),
          headers: headers, body: data);

      print(data);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> listSuggestCourse(
      String id, int limit, int offset) async {
    try {
      var client = http.Client();
      String params = id+"/"+limit.toString()+"/"+offset.toString();


      var res = await client.get(Uri.parse(apiUrl + "user/recommend-course/"+params),
          headers: headers);

      print(res.body);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> listUserProcessCourse() async {
    try {
      var client = http.Client();

      var res = await client.get(Uri.parse(apiUrl + 'user/get-process-courses'),
          headers: headers);

      print(res.body);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> listTopNewCourse(int limit, int page) async {
    try {
      var client = http.Client();
      String data = json.encode({
        "limit":limit,
        "page":page
      });

      var res = await client.post(Uri.parse(apiUrl + 'course/top-new'),
          headers: headers, body: data);

      print(data);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> listTopSellCourse(int limit, int page) async {
    try {
      var client = http.Client();
      String data = json.encode({
        "limit":limit,
        "page":page
      });

      var res = await client.post(Uri.parse(apiUrl + 'course/top-sell'),
          headers: headers, body: data);

      print(data);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> listAuthor() async {
    try {
      var client = http.Client();

      var res = await client.get(Uri.parse(apiUrl + 'instructor'),
          headers: headers);

      print(res.body);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }

  Future<Tuple2<int, Map<String, dynamic>>> searchAll(String keyword) async {
    try {
      var client = http.Client();
      var data ={
        "keyword": keyword
      };
      var res = await client.post(Uri.parse(apiUrl + 'course/searchV2'),
          headers: headers, body: data);

      print(res.body);
      return Tuple2(res.statusCode, json.decode(res.body));

    } catch (e) {
      print(e);
      return Tuple2(404, {"message":"Error not found"});
    }
  }
}
