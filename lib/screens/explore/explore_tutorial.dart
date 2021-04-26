import 'package:erasmus_projects/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter/material.dart';

void initTargets(targets, keyButtonDrawer, keyButtonCoffee) async {
  User user = await getCurrentUser();
  if (user != null) {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButtonDrawer,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Tap to see drawer",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "This show all the options you have to publish, explore and configure your projects.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  targets.add(
    TargetFocus(
      identify: "Target 1",
      keyTarget: keyButtonCoffee,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tap to donate to the project",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "If you would like top support this project, click the coffee mug!",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
