import 'package:erasmus_projects/screens/drawer/main_drawer.dart';
import 'package:erasmus_projects/screens/home_screen.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteAccountScreen extends StatelessWidget {
  static const String id = 'delete_account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: FutureBuilder(
          future: getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.vertical(
                            bottom: Radius.elliptical(350.0, 20.0),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/bandeira.jpeg')),
                        ),
                      ),
                      Positioned(
                        //left: 10.0,
                        top: 20,
                        child: FutureBuilder(
                            future: getCurrentUser(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return snapshot.data == null
                                  ? IconButton(
                                      icon: Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    )
                                  : Container();
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Would you like to delete your account?',
                          style: TextStyle(
                            color: kYellowGold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Once you delete your account all information and published projects will be permanently removed.',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Would you like to proceed?',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: kYellowGold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  User loggedInUser = snapshot.data;
                                  loggedInUser.delete();
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Account'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(
                                                'Account deleted successfully!',
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                HomeScreen.id,
                                                ModalRoute.withName(
                                                    HomeScreen.id),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: kYellowGold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  side: BorderSide(color: Colors.blue[900]),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return kProgressCircle;
            }
          }),
    );
  }
}
