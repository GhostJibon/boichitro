import 'package:flutter/material.dart';

class UserInfos {
  int id;
  String full_name;
  String gender;
  //String city;
  // String area_of_interest;
  String phone;
  String email;
  String username_type;

  UserInfos({
    required this.full_name,
    required this.gender,
    required this.id,
    required this.email,
    required this.phone,
    required this.username_type,
    // required this.area_of_interest,
    // required this.city,
  });

  factory UserInfos.fromjson(Map<String, dynamic> map) {
    return UserInfos(
        id: map["id"],
        full_name: map['full_name'] != null ? map['full_name'] : '',
        email: map["email"] != null ? map["email"] : '',
        phone: map["phone"] != null ? map['phone'] : '',
        // city: map['city'].toString(),
        // area_of_interest: map['area_of_interest'].toString(),
        gender: map['gender'] != null ? map['gender'] : 'Male',
        username_type:
            map['username_type'] != null ? map['username_type'] : '');
  }
  // String get fullname => this.full_name;
  // set fullname(value) => this.full_name = value;
  // get getGender => this.gender;
  // set setGender(gender) => this.gender = gender;
  // get getPhone => this.phone;
  // set setPhone(phone) => this.phone = phone;
  // get getEmail => this.email;
  // set setEmail(email) => this.email = email;
  // Map toJson() => {'full_name': full_name, 'email': email, 'phone': phone};
}
