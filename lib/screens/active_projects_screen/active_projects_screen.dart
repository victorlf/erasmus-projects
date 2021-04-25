//import 'dart:html';

import 'package:erasmus_projects/components/card_info.dart';
import 'package:erasmus_projects/components/card_info_slidable.dart';
import 'package:erasmus_projects/screens/active_projects_screen/card_info_slidable_key.dart';
import 'package:erasmus_projects/screens/active_projects_screen/active_projects_tutorial.dart';
import 'package:erasmus_projects/screens/drawer/main_drawer.dart';
import 'package:erasmus_projects/screens/publish_project_screen/publish_project_screen.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class ActiveProjectsScreen extends StatefulWidget {
  static const String id = "active_projects_screen";

  @override
  _ActiveProjectsScreenState createState() => _ActiveProjectsScreenState();
}

class _ActiveProjectsScreenState extends State<ActiveProjectsScreen> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keyButtonProject = GlobalKey();

  String dropdownValue1 = 'Recently Added';
  String dropdownValue2 = 'Country';
  double listHeight = 0.8;
  User loggedInUser;

  void showTutorial() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // if (prefs.getBool('watchedIntroActiveProjects') == null) {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.blue,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();

    //   prefs.setBool('watchedIntroActiveProjects', true);
    // }
  }

  @override
  initState() {
    super.initState();
    initTargets(targets, keyButtonProject);
    showTutorial();
  }

  @override
  dispose() {
    tutorialCoachMark.finish();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: Column(
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.data == null
                          ? IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.of(context).pop(),
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder(
                      future: getCurrentUser(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return snapshot.data != null
                            ? Builder(
                                builder: (context) => GestureDetector(
                                  onTap: () =>
                                      Scaffold.of(context).openDrawer(),
                                  child: FaIcon(
                                    FontAwesomeIcons.userCircle,
                                    color: kYellowGold,
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                    Text(
                      "Active Projects",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Container(),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  //key: keyButtonProject,
                  child: FutureBuilder(
                      future: getCurrentUser(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return snapshot.data != null
                            ? StreamBuilder(
                                stream: kFirebaseFirestore
                                    .collection('projects')
                                    .where('uid', isEqualTo: snapshot.data.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(child: kProgressCircle);
                                  return Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        listHeight,
                                    child: ListView.builder(
                                      //key: keyButtonProject,
                                      itemCount: snapshot.data.size,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Container(
                                            //key: keyButtonProject,
                                            child: Column(
                                              children: [
                                                InfoCardSlidableKey(
                                                  //key: keyButtonProject,
                                                  title: snapshot.data
                                                      .docs[index]['title'],
                                                  //country: snapshot.data.docs[index]['venue'],
                                                  country: snapshot.data
                                                      .docs[index]['country'],
                                                  beginDate: snapshot.data
                                                      .docs[index]['beginDate']
                                                      .toDate(),
                                                  endDate: snapshot.data
                                                      .docs[index]['endDate']
                                                      .toDate(),
                                                  eligibles: snapshot.data
                                                      .docs[index]['eligible'],
                                                  documentId: snapshot.data
                                                      .docs[index].reference.id,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              InfoCardSlidable(
                                                title: snapshot.data.docs[index]
                                                    ['title'],
                                                //country: snapshot.data.docs[index]['venue'],
                                                country: snapshot.data
                                                    .docs[index]['country'],
                                                beginDate: snapshot.data
                                                    .docs[index]['beginDate']
                                                    .toDate(),
                                                endDate: snapshot
                                                    .data.docs[index]['endDate']
                                                    .toDate(),
                                                eligibles: snapshot.data
                                                    .docs[index]['eligible'],
                                                documentId: snapshot.data
                                                    .docs[index].reference.id,
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  );
                                })
                            : Container();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
