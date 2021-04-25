//import 'dart:html';
import 'package:erasmus_projects/components/card_info.dart';
import 'package:erasmus_projects/models/user_model.dart';
import 'package:erasmus_projects/screens/drawer/main_drawer.dart';
import 'package:erasmus_projects/screens/explore/explore_tutorial.dart';
import 'package:erasmus_projects/screens/publish_project_screen/publish_project_screen.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  static const String id = "explore_screen";

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keyButtonDrawer = GlobalKey();
  GlobalKey keyButtonCoffee = GlobalKey();

  String dropdownValue1 = 'Recently Added';
  String dropdownValue2 = 'Country';
  double listHeight = 0.6;
  DateTime selectedDate;

  final TextEditingController _filter = TextEditingController();
  String _searchText = '';

  void showTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('watchedIntro') == null) {
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

      prefs.setBool('watchedIntro', true);
    }
  }

  Stream streamFromDatabase = kFirebaseFirestore
      .collection('projects')
      .orderBy('createdAt', descending: true)
      .snapshots();

  getProjects(String dropdownValue1, String dropdownValue2) async {
    //setState(() {
    if (dropdownValue2 != 'Country' && dropdownValue1 != 'Recently Added') {
      streamFromDatabase = kFirebaseFirestore
          .collection('projects')
          .where('country', isEqualTo: dropdownValue2)
          .orderBy('deadline')
          .snapshots();
    } else if (dropdownValue2 != 'Country') {
      streamFromDatabase = kFirebaseFirestore
          .collection('projects')
          .where('country', isEqualTo: dropdownValue2)
          .snapshots();
    } else if (dropdownValue1 != 'Recently Added') {
      streamFromDatabase = kFirebaseFirestore
          .collection('projects')
          .orderBy('deadline')
          .snapshots();
    } else {
      streamFromDatabase = kFirebaseFirestore
          .collection('projects')
          .orderBy('createdAt', descending: true)
          .snapshots();
    }
    //});
  }

  getInfoCard(snapshot, index) {
    return Column(
      children: [
        InfoCard(
          title: snapshot.data.docs[index]['title'],
          //country: snapshot.data.docs[index]['venue'],
          country: snapshot.data.docs[index]['country'],
          beginDate: snapshot.data.docs[index]['beginDate'].toDate(),
          endDate: snapshot.data.docs[index]['endDate'].toDate(),
          eligibles: snapshot.data.docs[index]['eligible'],
          documentId: snapshot.data.docs[index].reference.id,
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  _ExploreScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = '';
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    selectedDate = DateTime.now();
    initTargets(targets, keyButtonDrawer, keyButtonCoffee);
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
      resizeToAvoidBottomInset: false,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
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
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    if (prefs.getString('userName') == null) {
                                      UserModel user = await UserModel(
                                              email: kAuth.currentUser.email)
                                          .getUserData();
                                      await prefs.setString(
                                          'userName', user.name);
                                    }
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.userCircle,
                                    key: keyButtonDrawer,
                                    color: kYellowGold,
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        //style: TextStyle(height: 0.2),
                        controller: _filter,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            prefixIcon: Icon(
                              Icons.search,
                              color: kYellowGold,
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Explore...',
                            hintStyle: TextStyle(
                              color: kYellowGold,
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch("https://ko-fi.com/olientreprise",
                            forceWebView: true);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.coffee,
                        key: keyButtonCoffee,
                        color: kYellowGold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: dropdownValue1,
                      icon: const FaIcon(
                        FontAwesomeIcons.angleDown,
                        color: kYellowGold,
                      ),
                      iconSize: 14,
                      elevation: 16,
                      style: const TextStyle(color: kYellowGold),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue1 = newValue;
                          getProjects(dropdownValue1, dropdownValue2);
                        });
                      },
                      items: <String>['Recently Added', 'Near deadline']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const FaIcon(
                        FontAwesomeIcons.angleDown,
                        color: kYellowGold,
                      ),
                      iconSize: 14,
                      elevation: 16,
                      style: const TextStyle(color: kYellowGold),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue2 = newValue;
                          getProjects(dropdownValue1, dropdownValue2);
                        });
                      },
                      items: <String>[
                        'Country',
                        'Brazil',
                        'Portugal',
                        'France',
                        'Germany',
                        'United States',
                        'Argentina',
                        'Italy',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                StreamBuilder(
                    stream: streamFromDatabase,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: kProgressCircle);
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * listHeight,
                        child: ListView.builder(
                          itemCount: snapshot.data.size,
                          itemBuilder: (context, index) {
                            if (_searchText.isNotEmpty) {
                              if (snapshot.data.docs[index]['title']
                                  .toLowerCase()
                                  .contains(_searchText.toLowerCase())) {
                                return getInfoCard(snapshot, index);
                              } else {
                                return Container();
                              }
                            } else {
                              return getInfoCard(snapshot, index);
                            }
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
          FutureBuilder(
              future: getCurrentUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  listHeight = 0.6;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PublishProjectScreen.id);
                      },
                      child: Text(
                        "Publish",
                        style: TextStyle(
                          color: kYellowGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  );
                } else {
                  listHeight = 0.7;
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
