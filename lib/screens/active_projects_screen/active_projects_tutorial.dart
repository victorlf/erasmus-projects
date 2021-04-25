import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter/material.dart';

void initTargets(targets, keyButtonProject) {
  targets.add(
    TargetFocus(
      identify: "Target 0",
      keyTarget: keyButtonProject,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Slide to the left to Edit or Delete a Project",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: Text(
                //     "This show all the options you have to publish, explore and configure your projects.",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ],
      shape: ShapeLightFocus.RRect,
      // radius: 3,
    ),
  );
}
