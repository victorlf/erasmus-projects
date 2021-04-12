//import 'dart:html';

import 'package:erasmus_projects/components/card_info.dart';
import 'package:erasmus_projects/screens/drawer/main_drawer.dart';
import 'package:erasmus_projects/screens/publish_project_screen/publish_project_screen.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExploreScreen extends StatefulWidget {
  static const String id = "explore_screen";

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String dropdownValue1 = 'Recently Added';
  String dropdownValue2 = 'Country';
  double listHeight = 0.6;

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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        //style: TextStyle(height: 0.2),
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
                        launch("https://ko-fi.com/olientreprise");
                      },
                      child: FaIcon(
                        FontAwesomeIcons.coffee,
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
                        });
                      },
                      items: <String>['Country', 'Portugal', 'Spain']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                StreamBuilder(
                    stream:
                        kFirebaseFirestore.collection('projects').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: kProgressCircle);
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * listHeight,
                        child: ListView.builder(
                          itemCount: snapshot.data.size,
                          itemBuilder: (context, index) => Column(
                            children: [
                              InfoCard(
                                title: snapshot.data.docs[index]['title'],
                                country: snapshot.data.docs[index]['venue'],
                                beginDate: snapshot.data.docs[index]
                                    ['beginDate'],
                                endDate: snapshot.data.docs[index]['endDate'],
                                eligibles: snapshot.data.docs[index]
                                    ['eligible'],
                                documentId:
                                    snapshot.data.docs[index].reference.id,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
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
