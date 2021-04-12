import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';

class UserModel {
  static const NAME = 'name';
  static const PIC = 'pic';
  static const EMAIL = 'email';

  final String name;
  final String pic;
  final String email;

  UserModel({this.name, this.pic = 'none', @required this.email});

  String get getName => name;
  // String get getPic => pic;
  //String get getEmail => email;

  CollectionReference users = kFirebaseFirestore.collection('users');

  addSnaphot() {
    return users
        .add({NAME: name, PIC: pic, EMAIL: email})
        .then((value) => print("User Added"))
        .catchError((onError) => print("Failed to add user: $onError"));
  }

  Future<UserModel> getUserData() async {
    return await users
        .where('email', isEqualTo: email)
        .get()
        .then((value) => UserModel(
              name: value.docs[0].data()[NAME],
              pic: value.docs[0].data()[PIC],
              email: value.docs[0].data()[EMAIL],
            ));
  }
}
