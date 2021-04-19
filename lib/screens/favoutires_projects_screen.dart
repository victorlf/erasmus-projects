//import 'dart:html';

import 'package:erasmus_projects/components/card_info.dart';
import 'package:erasmus_projects/components/card_info_slidable.dart';
import 'package:erasmus_projects/screens/drawer/main_drawer.dart';
import 'package:erasmus_projects/screens/publish_project_screen/publish_project_screen.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class FavouritesProjectsScreen extends StatefulWidget {
  static const String id = "favourites_projects_screen";

  @override
  _FavouritesProjectsScreenState createState() =>
      _FavouritesProjectsScreenState();
}

class _FavouritesProjectsScreenState extends State<FavouritesProjectsScreen> {
  String dropdownValue1 = 'Recently Added';
  String dropdownValue2 = 'Country';
  double listHeight = 0.6;
  User loggedInUser;

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
                    Text(
                      "Favourites Projects",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Container(),
                  ],
                ),
                FutureBuilder(
                    future: getCurrentUser(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.data != null
                          ? StreamBuilder(
                              stream: kFirebaseFirestore
                                  .collection('projects')
                                  .where('favourites',
                                      arrayContains: snapshot.data.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Center(child: kProgressCircle);
                                return Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height *
                                      listHeight,
                                  child: ListView.builder(
                                    itemCount: snapshot.data.size,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        InfoCardSlidable(
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          //country: snapshot.data.docs[index]['venue'],
                                          country: snapshot.data.docs[index]
                                              ['country'],
                                          beginDate: snapshot
                                              .data.docs[index]['beginDate']
                                              .toDate(),
                                          endDate: snapshot
                                              .data.docs[index]['endDate']
                                              .toDate(),
                                          eligibles: snapshot.data.docs[index]
                                              ['eligible'],
                                          documentId: snapshot
                                              .data.docs[index].reference.id,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Container();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
