import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';

class InfoData extends StatelessWidget {
  final String title;
  final String info;

  InfoData({@required this.title, @required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '${title}:',
        style: TextStyle(color: kYellowGold),
      ),
      SizedBox(
        width: 25.0,
      ),
      Flexible(
        child: Text(
          info,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    ]);
  }
}
