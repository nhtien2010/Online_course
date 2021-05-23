import 'dart:core';

import 'UserModel.dart';

class CourseModel {
  String id;
  String title;

  String subtitle;

  int price;
  String description;

  List<String> requirement;
  List<String> learnWhat;

  int soldNumber;

  int ratedNumber;

  int videoNumber;

  num totalHours;

  num formalityPoint;

  num contentPoint;

  num presentationPoint;

  String imageUrl;
  String promoVidUrl;
  String status;

  bool isHidden;
  DateTime createdAt;
  DateTime updatedAt;
  String instructorId;

  int typeUploadVideoLesson;

  UserModel instructor;

  CourseModel(
      {this.id,
      this.title,
      this.subtitle,
      this.price,
      this.description,
      this.requirement,
      this.learnWhat,
      this.soldNumber,
      this.ratedNumber,
      this.videoNumber,
      this.totalHours,
      this.formalityPoint,
      this.contentPoint,
      this.presentationPoint,
      this.imageUrl,
      this.promoVidUrl,
      this.status,
      this.isHidden,
      this.createdAt,
      this.updatedAt,
      this.instructorId,
      this.typeUploadVideoLesson,
      this.instructor});

  factory CourseModel.fromJson(Map<String, dynamic> json){
    CourseModel course;
    try {
      course = CourseModel(
        id : json['id'] != null ? json['id']: "",
        title : json['title'] != null ? json['title']: "",
        subtitle : json['subtitle'] != null ? json['subtitle']: "",
        price : json['price'] != null ? json['price']: -1,


        description : json['description'] != null ? json['description']: "",
        requirement : json["requirement"] != null ? List<String>.from(json["requirement"].map((x) => x)) : null,
        learnWhat : json["learnWhat"] != null ? List<String>.from(json["learnWhat"].map((x) => x)) : null,

        soldNumber : json['soldNumber'] != null ? json['soldNumber']: -1,
        ratedNumber : json['ratedNumber'] != null ? json['ratedNumber']: -1,
        videoNumber : json['videoNumber'] != null ? json['videoNumber']: -1,

        totalHours : json['totalHours'] != null ? json['totalHours']: -1,
        formalityPoint : json['formalityPoint'] != null ? json['formalityPoint']: -1,
        contentPoint : json['contentPoint'] != null ? json['contentPoint']: -1,
        presentationPoint : json['presentationPoint'] != null ? json['presentationPoint']: -1,


        imageUrl : json['imageUrl'] != null ? json['imageUrl']: "",
        promoVidUrl : json['promoVidUrl'] != null ? json['promoVidUrl']: "",
        status : json['status'] != null ? json['status']: "",

        isHidden : json['isHidden'] != null ? json['isHidden']: true,
        createdAt: json["createdAt"]!=  null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ?  DateTime.parse(json["updatedAt"]) : null,

        instructorId : json['instructorId'] != null ? json['instructorId']: "",
        typeUploadVideoLesson : json['typeUploadVideoLesson'] != null ? json['typeUploadVideoLesson']: -1,
        instructor: json['instructor.user.id'] != null ?
                      json['instructor.user.name'] != null ? UserModel(id: json['instructor.user.id'], name: json['instructor.user.name'])
                      : null : null,
      );
    }catch(e){
      print(e);
    }

    return course;
  }
// List<String> section;

// String  instructor	{...}''

// String  Enum:;
// String   Array [ 2 ];
// String   createdAt	($date-time);
// String  updatedAt	($date-time);
// String   instructorId	($uuid);
// String   1: Upload File, 2: Link Youtube
//
// String   section	[...];
// String  ratings	[...];
// String   averagePoint	number;

// String   coursesLikeCategory	[...];

}
