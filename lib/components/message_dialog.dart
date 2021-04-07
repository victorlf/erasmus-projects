// import 'package:flutter/material.dart';

// Future<void> messageDialog(
//     {context,
//     @required String title,
//     @required String message,
//     @required String buttonTitle,
//     @required String goToSreenRoute}) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(message),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text(buttonTitle),
//             onPressed: () {
//               if (goToSreenRoute != null or goToScreenRoute != '') {
//               Navigator.pushNamed(context, goToSreenRoute);
//               } else {
//                 Navigator.of(context).pop();
//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
