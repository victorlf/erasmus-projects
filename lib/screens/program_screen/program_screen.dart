import 'package:erasmus_projects/components/info_data.dart';
import 'package:erasmus_projects/models/project_model.dart';
import 'package:erasmus_projects/screens/program_screen/program_args.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:erasmus_projects/services/get_files.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:erasmus_projects/utilities/date_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgramScreen extends StatefulWidget {
  static const String id = 'program_screen';

  @override
  _ProgramScreenState createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  bool isFav = false;

  Future<bool> isApplyButtonEnabled(url) async {
    bool isUrl = await canLaunch(url) ? true : false;
    return isUrl;
  }

  Function launchFuntion(url) {
    return () {
      launch(url, forceWebView: true);
    };
  }

  @override
  Widget build(BuildContext context) {
    favoriteHeart(bool isFav) {
      if (isFav) {
        return FaIcon(
          FontAwesomeIcons.solidHeart,
          color: Colors.red,
        );
      } else {
        return FaIcon(FontAwesomeIcons.heart);
      }
    }

    final ProgramArgs args =
        ModalRoute.of(context).settings.arguments as ProgramArgs;

    return Scaffold(
      body: StreamBuilder(
          stream: kFirebaseFirestore
              .collection('projects')
              .doc(args.documentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: kProgressCircle);
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    pinned: false,
                    expandedHeight: MediaQuery.of(context).size.height * 0.5,
                    flexibleSpace: Stack(
                      children: [
                        Positioned(
                            child: FutureBuilder(
                                //future: downloadURL(snapshot.data['venue']),
                                future: downloadURL(snapshot.data['country']),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  //if (!snapshot.hasData) return Center(child: kProgressCircle);
                                  if (!snapshot.hasData) return Container();
                                  return Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapshot.data),
                                  );
                                }),
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0),
                        Positioned(
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 30.0,
                                right: 30.0,
                                left: 30.0,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 250.0,
                                    child: Text(
                                      //"Rethinking – Reconnecting – Rebuilding (Title)",
                                      snapshot.data['title'],
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Positioned(
                                    right: 10.0,
                                    top: 20,
                                    child: FutureBuilder(
                                        future: getCurrentUser(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshotUser) {
                                          if (!snapshotUser.hasData)
                                            return Container();
                                          User loggedInUser = snapshotUser.data;
                                          String uid = loggedInUser.uid;
                                          List favouritesList =
                                              snapshot.data['favourites'];
                                          isFav = favouritesList.contains(uid);
                                          return GestureDetector(
                                              onTap: () async {
                                                ProjectModel p = ProjectModel();
                                                bool isSuccess = false;
                                                if (!isFav) {
                                                  isSuccess =
                                                      await p.addToFavourites(
                                                          uid, args.documentId);
                                                } else {
                                                  isSuccess = await p
                                                      .removeFromFavourites(
                                                          uid, args.documentId);
                                                }
                                                if (isSuccess) {
                                                  setState(() {
                                                    isFav = !isFav;
                                                  });
                                                }
                                              },
                                              child: favoriteHeart(isFav));
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          bottom: -1,
                          left: 0,
                          right: 0,
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ListView(
                    children: [
                      InfoData(
                        title: 'Organization',
                        info: snapshot.data['organization'],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoData(
                        title: 'Dates',
                        info:
                            '${parseDateToString(snapshot.data['beginDate'].toDate())} - ${parseDateToString(snapshot.data['endDate'].toDate())}',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      // InfoData(
                      //   title: 'Venue',
                      //   info: snapshot.data['venue'],
                      // ),
                      InfoData(
                        title: 'City',
                        info: snapshot.data['city'],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoData(
                        title: 'Country',
                        info: snapshot.data['country'],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Wrap(
                        spacing: 2.0,
                        runSpacing: 5.0,
                        children: [
                          Text(
                            'Eligible Countries:',
                            style: TextStyle(color: kYellowGold),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          for (String eligible in snapshot.data['eligible'])
                            Text(
                              eligible,
                              style: TextStyle(
                                color: Colors.blue[900],
                                backgroundColor: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoData(
                        title: 'Application deadline',
                        info:
                            '${parseDateToString(snapshot.data['deadline'].toDate())}',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoData(
                        title: 'Type',
                        info: snapshot.data['type'],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Wrap(
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(color: kYellowGold),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            //'BfT serves as a platform to contribute to exploring the next steps to be undertaken in the ETS development and to reflect on what role Erasmus+ Youth Programme and the European Solidarity Corps could play in this. BfT takes place every two years and is a conference concept bringing together experienced trainers, other training providers, and Erasmus+ Youth Programme and European Solidarity Corps NA/SALTO RC staff working with trainers / trainer pools to reflect on trends and core issues in the youth field and effects on the work of trainers. In 2020, trainers and training providers with existing training strategies for trainers at national or international level are invited to join the first online edition of Bridges for Trainers and explore the changes that the field went through in the past months – mostly due to the COVID-19 crisis, as well as what is ahead of us (role of training, new programmes, change of learning spaces and approaches, etc.).',
                            snapshot.data['description'],
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      (snapshot.data['infopack'] !=
                              'Click to Attach your Infopack')
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                    'Infopack',
                                    style: TextStyle(color: kYellowGold),
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      launch(
                                        await downloadInfopackURL(
                                          snapshot.data['title'],
                                          snapshot.data['infopack'],
                                          snapshot.data['deadline'],
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Download',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ])
                          : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoData(
                        title: 'Cost',
                        info: snapshot.data['cost'],
                      ),
                      snapshot.data['cost'] == 'Customized'
                          ? Wrap(
                              children: [
                                Text(
                                  'Customized Cost Description:',
                                  style: TextStyle(color: kYellowGold),
                                ),
                                SizedBox(
                                  width: 25.0,
                                ),
                                Text(
                                  snapshot.data['customizedCost'],
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoData(
                        title: 'Contact',
                        info: snapshot.data['contact'],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FutureBuilder(
                          future: isApplyButtonEnabled(
                              snapshot.data['applyButton']),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshotApplyButton) {
                            return snapshotApplyButton.data != null
                                ? ElevatedButton(
                                    onPressed: snapshotApplyButton.data
                                        ? launchFuntion(
                                            snapshot.data['applyButton'])
                                        : null,
                                    child: snapshotApplyButton.data
                                        ? Text(
                                            "Apply",
                                            style: TextStyle(
                                              color: kYellowGold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          )
                                        : Text(
                                            'Link is not working',
                                            style: TextStyle(
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
                                  )
                                : Container();
                          }),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
