import 'package:flutter/material.dart';

bool validateAndSave(FormState formCurrentState) {
  //final FormState form = _formKey.currentState;
  if (formCurrentState.validate()) {
    print('Form is valid');
    return true;
  } else {
    print('Form is invalid');
    return false;
  }
}
