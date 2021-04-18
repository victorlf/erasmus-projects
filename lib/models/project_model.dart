import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_projects/utilities/constants.dart';

class ProjectModel {
  static const TITLE = 'title';
  static const BEGIN = 'beginDate';
  static const END = 'endDate';
  //static const VENUE = 'venue';
  static const CITY = 'city';
  static const COUNTRY = 'country';
  static const ORGANIZATION = 'organization';
  static const ELIGIBLE = 'eligible';
  static const DEADLINE = 'deadline';
  static const TYPE = 'type';
  static const DESCRIPTION = 'description';
  static const TAGS = 'tags';
  static const INFOPACK = 'infopack';
  static const COST = 'cost';
  static const CUSTOMIZEDCOST = 'customizedCost';
  static const CONTACT = 'contact';
  static const APPLY = 'applyButton';
  static const UID = 'uid';

  final String title;
  //final String beginDate;
  final DateTime beginDate;
  final DateTime endDate;
  //final String venue;
  final String city;
  final String country;
  final String organization;
  final List<String> eligible;
  final DateTime deadline;
  final String type;
  final String description;
  final List<String> tags;
  final String infopack;
  final String cost;
  final String customizedCost;
  final String contact;
  final String applyButton;
  final File infopackPath;
  final String uid;

  ProjectModel(
      {this.title,
      this.beginDate,
      this.endDate,
      //this.venue,
      this.city,
      this.country,
      this.organization,
      this.eligible,
      this.deadline,
      this.type,
      this.description,
      this.tags,
      this.infopack,
      this.infopackPath,
      this.cost,
      this.customizedCost,
      this.contact,
      this.applyButton,
      this.uid});

  CollectionReference projects = kFirebaseFirestore.collection('projects');

  addSnapshot() {
    return projects.add({
      TITLE: title,
      BEGIN: beginDate,
      END: endDate,
      //VENUE: venue,
      CITY: city,
      COUNTRY: country,
      ORGANIZATION: organization,
      ELIGIBLE: eligible,
      DEADLINE: deadline,
      TYPE: type,
      DESCRIPTION: description,
      TAGS: tags,
      INFOPACK: infopack,
      COST: cost,
      CUSTOMIZEDCOST: customizedCost,
      CONTACT: contact,
      APPLY: applyButton,
      UID: uid,
    }).then((value) async {
      print('Project Added');
      bool isSuccess;
      infopackPath != null
          ? isSuccess =
              await fileUpload(title, infopackPath, infopack, deadline)
          : isSuccess = true;
      return isSuccess;
    }).catchError((onError) {
      print("Failed to add user: $onError");
      return false;
    });
  }

  updateSnapshot(documentId) {
    return projects.doc(documentId).update({
      TITLE: title,
      BEGIN: beginDate,
      END: endDate,
      //VENUE: venue,
      CITY: city,
      COUNTRY: country,
      ORGANIZATION: organization,
      ELIGIBLE: eligible,
      DEADLINE: deadline,
      TYPE: type,
      DESCRIPTION: description,
      TAGS: tags,
      INFOPACK: infopack,
      COST: cost,
      CUSTOMIZEDCOST: customizedCost,
      CONTACT: contact,
      APPLY: applyButton,
      UID: uid,
    }).then((value) async {
      print('Project Added');
      bool isSuccess;
      infopackPath != null
          ? isSuccess =
              await fileUpload(title, infopackPath, infopack, deadline)
          : isSuccess = true;
      return isSuccess;
    }).catchError((onError) {
      print("Failed to add user: $onError");
      return false;
    });
  }

  deleteSnapshot(documentId) {
    return projects.doc(documentId).delete().then((value) async {
      print('Project Deleted');
      return true;
    }).catchError((onError) {
      print("Failed to delete project: $onError");
      return false;
    });
  }
}

fileUpload(projectTitle, filePath, fileName, deadline) async {
  return await kFirebaseStorage
      .ref('projects')
      .child('${projectTitle}_${fileName}_${deadline}')
      .child('${fileName}')
      .putFile(filePath)
      .then((value) {
    print('File Uploaded');
    return true;
  }).catchError((onError) {
    print("Failed to upload file: $onError");
    return false;
  });
}
