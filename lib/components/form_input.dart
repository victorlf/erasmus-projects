import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String title;
  final String inputHint;
  final TextEditingController controller;
  final isPassword;
  final keyboardType;
  final validator;

  FormInput({
    @required this.title,
    @required this.inputHint,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
  });

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
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              isDense: true,
              hintText: inputHint,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            validator: validator,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
