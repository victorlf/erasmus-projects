import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String title;
  final String inputHint;

  FormInput({this.title, this.inputHint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: kYellowGold,
          ),
        ),
        Container(
          width: 300.0,
          child: TextField(
            //style: TextStyle(height: 0.2),
            decoration: InputDecoration(
              isDense: true,
              hintText: inputHint,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
