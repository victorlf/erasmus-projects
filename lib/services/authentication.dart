import 'dart:io';

import 'package:erasmus_projects/models/user_model.dart';
import 'package:erasmus_projects/screens/explore/explore_screen.dart';
import 'package:erasmus_projects/screens/home_screen.dart';
import 'package:erasmus_projects/screens/organization_signin_screen.dart';
import 'package:erasmus_projects/services/network.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';

Future<bool> verifyPICNumber(String pic) async {
  final response = await http.get(Uri.parse(
      'https://ec.europa.eu/info/funding-tenders/opportunities/api/orgProfile/data.json?pic=${pic}'));

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('PIC number does exist');
    return true;
  } else {
    print(response.statusCode);
    print('PIC number doesn\'t exist');
    return false;
  }
}

Future registerOrganizationAuthentication(context, String name,
    String organizationPic, String email, String password, isBoxChecked) async {
  if (!isBoxChecked) {
    try {
      bool isValid = await verifyPICNumber(organizationPic);
      if (!isValid) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('PIC Number Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'PIC Number used doesn\'t exist in the ec.europa.eu database!',
                    ),
                    Text(
                      'Please, check if the number is correct',
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }

  try {
    final newUser = await kAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (newUser != null) {
      UserModel userModel =
          UserModel(name: name, pic: organizationPic, email: email);
      userModel.addSnaphot();

      await newUser.user.sendEmailVerification();

      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verify Email'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'A verification email was sent to you, please go check and confirm before Log in!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Go Sign In'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    OrganizationSigninScreen.id,
                    ModalRoute.withName(HomeScreen.id),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  } catch (signUpError) {
    print(signUpError.code);
    if (signUpError.code == 'email-already-in-use') {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Email already in use!',
                  ),
                  Text(
                    'Please, use another email.',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

Future organizationSigninAuthentication(
    context, String email, String password) async {
  bool isConnected = await checkNetworkConnection();

  if (!isConnected) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Network Problem'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please, verify your network connection.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  try {
    final user = await kAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (user != null) {
      if (user.user.emailVerified) {
        //Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(
          context,
          ExploreScreen.id,
          ModalRoute.withName(ExploreScreen.id),
        );
        //Navigator.pushNamed(context, ExploreScreen.id);
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign In Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Email isn\'t verified!'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  } catch (signUpError) {
    print(signUpError.code);
    String error;
    if (signUpError.code == 'wrong-password') {
      error = 'Incorrect password!';
    } else if (signUpError.code == 'user-not-found') {
      error = 'Email not found!';
    } else {
      error = 'Incorrect email or password!';
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign In Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(error),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<User> getCurrentUser() async {
  try {
    final user = kAuth.currentUser;
    if (user != null) {
      User loggedInUser = user;
      print(loggedInUser.email);
      return loggedInUser;
    }
  } catch (e) {
    print(e);
  }
}

getCurrentUser2() async {
  try {
    final user = kAuth.currentUser;
    if (user != null) {
      User loggedInUser = user;
      //print(loggedInUser.email);
      return loggedInUser;
    }
  } catch (e) {
    print(e);
  }
}
