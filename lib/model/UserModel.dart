
import 'dart:core';

class UserModel {
  String id;
  String name;
  String email;
  String avatar;
  String phone;
  String type;

  bool isDeleted;
  bool isActivated;

  List<String> favoriteCategories;

  DateTime createdAt;
  DateTime updatedAt;

  String password;
  // String token;


  UserModel({this.id, this.name, this.email, this.avatar, this.phone, this.type,
      this.isDeleted, this.isActivated, this.favoriteCategories, this.createdAt,
      this.updatedAt,this.password,
    });

  factory UserModel.fromJson(Map<String, dynamic> json){
    UserModel user;
    try{
      user = UserModel(
        id : json['id'] != null ? json['id']: "",
        email : json['email'] != null ? json['email']: "",
        avatar : json['avatar'] != null ? json['avatar']: "",
        name : json['name'] != null ? json['name']: "",

        favoriteCategories : json["favoriteCategories"] != null ? List<String>.from(json["favoriteCategories"].map((x) => x)) : null,
        phone : json['phone'] != null ? json['phone']: "",
        type : json['type'] != null ? json['type']: "",
        isActivated : json['isActivated'] != null ? json['isActivated']: true,
        isDeleted : json['isDeleted'] != null ? json['isDeleted']: true,

        createdAt: json["createdAt"]!=  null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ?  DateTime.parse(json["updatedAt"]) : null,
      );
    }catch(e){
      print(e);
    }
    return user;
  }

  Map<String, dynamic> toJson() => {
    'name':name,
    'email':email,
    'phone':phone,
    'password':password,
  };
}

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  UserModel model;
  String token;
}