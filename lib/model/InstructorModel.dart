import 'package:online_course/model/UserModel.dart';

class InstructorModel {
  String id;

  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  String major;
  String intro;
  List<String> skills;
  int cumulativeTuition;
  UserModel userModel;

  InstructorModel(
      {this.id,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.skills,
      this.userId,
      this.major,
      this.intro,
      this.cumulativeTuition,
      this.userModel});

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    InstructorModel user;
    try {
      user = InstructorModel(
        id: json['id'] != null ? json['id'] : "",
        userId: json['userId'] != null ? json['userId'] : "",
        major: json['major'] != null ? json['major'] : "",
        intro: json['intro'] != null ? json['intro'] : "",
        cumulativeTuition:
            json['cumulativeTuition'] != null ? json['cumulativeTuition'] : 0,
        skills: json["skills"] != null
            ? List<String>.from(json["skills"].map((x) => x))
            : null,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        isDeleted: json['isDeleted'] != null ? json['isDeleted'] : true,
        userModel: UserModel(
          id: json['user.id'] != null ? json['user.id'] : "",
          email: json['user.email'] != null ? json['user.email'] : "",
          avatar: json['user.avatar'] != null ? json['user.avatar'] : "",
          name: json['user.name'] != null ? json['user.name'] : "",
          favoriteCategories: json["user.favoriteCategories"] != null
              ? List<String>.from(json["user.favoriteCategories"].map((x) => x))
              : null,
          phone: json['user.phone'] != null ? json['user.phone'] : "",
          type: json['user.type'] != null ? json['user.type'] : "",
          isActivated: json['user.isActivated'] != null
              ? json['user.isActivated']
              : true,
          isDeleted:
              json['user.isDeleted'] != null ? json['user.isDeleted'] : true,
          createdAt: json["user..createdAt"] != null
              ? DateTime.parse(json["user.createdAt"])
              : null,
          updatedAt: json["user.updatedAt"] != null
              ? DateTime.parse(json["user.updatedAt"])
              : null,
        ),
      );
    } catch (e) {
      print(e);
    }
    return user;
  }
}
