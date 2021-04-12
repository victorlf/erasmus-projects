import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';

Future downloadURL(String country) async {
  String downloadURL =
      await kFirebaseStorage.ref('flags/${country}.jpg').getDownloadURL();

  // return CircleAvatar(
  //   radius: 30.0,
  //   backgroundImage: NetworkImage(downloadURL),
  //   backgroundColor: Colors.transparent,
  // );
  return downloadURL;
}

Future downloadInfopackURL(
    String projectTitle, String fileName, String deadline) async {
  String downloadURL = await kFirebaseStorage
      .ref('projects/${projectTitle}_${fileName}_${deadline}/$fileName')
      .getDownloadURL();

  // return CircleAvatar(
  //   radius: 30.0,
  //   backgroundImage: NetworkImage(downloadURL),
  //   backgroundColor: Colors.transparent,
  // );
  return downloadURL;
}

// ref('projects')
//       .child('${projectTitle}_${fileName}_${deadline}')
//       .child('${fileName}')
//       .putFile(filePath)
