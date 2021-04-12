import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_projects/utilities/constants.dart';

class ProjectModel {
  static const TITLE = 'title';
  static const BEGIN = 'beginDate';
  static const END = 'endDate';
  static const VENUE = 'venue';
  static const ORGANIZATION = 'organization';
  static const ELIGIBLE = 'eligible';
  static const DEADLINE = 'deadline';
  static const TYPE = 'type';
  static const DESCRIPTION = 'description';
  static const TAGS = 'tags';
  static const INFOPACK = 'infopack';
  static const COST = 'cost';
  static const CONTACT = 'contact';
  static const APPLY = 'applyButton';

  final String title;
  final String beginDate;
  final String endDate;
  final String venue;
  final String organization;
  final List<String> eligible;
  final String deadline;
  final String type;
  final String description;
  final List<String> tags;
  final String infopack;
  final String cost;
  final String contact;
  final String applyButton;
  final File infopackPath;

  ProjectModel(
      {this.title,
      this.beginDate,
      this.endDate,
      this.venue,
      this.organization,
      this.eligible,
      this.deadline,
      this.type,
      this.description,
      this.tags,
      this.infopack,
      this.infopackPath,
      this.cost,
      this.contact,
      this.applyButton});

  CollectionReference projects = kFirebaseFirestore.collection('projects');

  addSnapshot() {
    return projects.add({
      TITLE: title,
      BEGIN: beginDate,
      END: endDate,
      VENUE: venue,
      ORGANIZATION: organization,
      ELIGIBLE: eligible,
      DEADLINE: deadline,
      TYPE: type,
      DESCRIPTION: description,
      TAGS: tags,
      INFOPACK: infopack,
      COST: cost,
      CONTACT: contact,
      APPLY: applyButton,
    }).then((value) async {
      print('Project Added');
      //return true;
      bool isSuccess = await fileUpload(title, infopackPath, infopack);
      return isSuccess;
    }).catchError((onError) {
      print("Failed to add user: $onError");
      return false;
    });
  }
}

fileUpload(projectTitle, filePath, fileName) async {
  return await kFirebaseStorage
      .ref('projects')
      .child('${projectTitle}')
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