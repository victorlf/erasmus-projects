import 'package:erasmus_projects/models/project_model.dart';
import 'package:erasmus_projects/screens/active_projects_screen/active_projects_tutorial.dart';
import 'package:erasmus_projects/screens/program_screen/program_args.dart';
import 'package:erasmus_projects/screens/program_screen/program_screen.dart';
import 'package:erasmus_projects/screens/publish_project_screen/edit_project_screen.dart';
import 'package:erasmus_projects/services/get_files.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:erasmus_projects/utilities/date_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class InfoCardSlidableKey extends StatefulWidget {
  final String title;
  final String country;
  final DateTime beginDate;
  final DateTime endDate;
  final List eligibles;
  final String documentId;

  InfoCardSlidableKey({
    this.title,
    this.country,
    this.beginDate,
    this.endDate,
    this.eligibles,
    this.documentId,
  });

  @override
  _InfoCardSlidableKeyState createState() => _InfoCardSlidableKeyState();
}

class _InfoCardSlidableKeyState extends State<InfoCardSlidableKey> {
  TutorialCoachMark tutorialCoachMark;

  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey keyButtonProject = GlobalKey();

  void showTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('watchedIntroActiveProjects') == null) {
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

      prefs.setBool('watchedIntroActiveProjects', true);
    }
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
    void _showSnackBar(BuildContext context, String text) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text)));
    }

    return Slidable(
      key: keyButtonProject,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          //alignment:new Alignment(x, y)
          children: <Widget>[
            Container(
              //color: Colors.grey[350],
              width: 280.0,
              height: 110.0,
              decoration: new BoxDecoration(
                color: Colors.grey[350],
                borderRadius: new BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    //color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //'Self Cara fot You(th)',
                    widget.title,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      iconImage('assets/images/icons/location.png'),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        //'Poland',
                        widget.country,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      iconImage('assets/images/icons/calendar.png'),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        //'27th Oct - 4th Nov',
                        '${parseDateToString(widget.beginDate)} - ${parseDateToString(widget.endDate)}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      iconImage('assets/images/icons/finish.png'),
                      SizedBox(
                        width: 5.0,
                      ),
                      eligiblesList(widget.eligibles),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: -20.0,
              top: 20,
              child: FutureBuilder(
                  future: downloadURL(widget.country),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //if (!snapshot.hasData) return Center(child: kProgressCircle);
                    if (!snapshot.hasData) return Container();
                    return CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(snapshot.data),
                      backgroundColor: Colors.transparent,
                    );
                  }),
            ),
            Positioned(
              right: -10.0,
              top: 30,
              child: GestureDetector(
                onTap: () {
                  print('ID: ${widget.documentId}');
                  Navigator.pushNamed(
                    context,
                    ProgramScreen.id,
                    arguments: ProgramArgs(documentId: widget.documentId),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, color: Colors.grey, spreadRadius: 2)
                    ],
                  ),
                  child: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      child: FaIcon(
                        FontAwesomeIcons.angleRight,
                        color: kYellowGold,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          //caption: 'Edit',
          //color: Colors.black45,
          //icon: Icons.more_horiz,
          iconWidget: Icon(
            FontAwesomeIcons.edit,
            color: Colors.blue[900],
          ),
          onTap: () {
            //_showSnackBar(context, 'Edit');
            Navigator.pushNamed(
              context,
              EditProjectScreen.id,
              arguments: ProgramArgs(documentId: widget.documentId),
            );
          },
        ),
        IconSlideAction(
          //caption: 'Delete',
          //color: Colors.red,
          //icon: Icons.delete,
          iconWidget: Icon(
            FontAwesomeIcons.trash,
            color: Colors.blue[900],
          ),
          onTap: () async {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Project'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          'Do you really want to delete this project?',
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () async {
                        ProjectModel projectModel = ProjectModel();
                        bool isDeleteOk = await projectModel
                            .deleteSnapshot(widget.documentId);
                        if (isDeleteOk) return Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            // } else {
            //   return showDialog<void>(
            //     context: context,
            //     barrierDismissible: false, // user must tap button!
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: Text('Error'),
            //         content: SingleChildScrollView(
            //           child: ListBody(
            //             children: <Widget>[
            //               Text(
            //                 'Project was not deleted!',
            //               ),
            //             ],
            //           ),
            //         ),
            //         actions: <Widget>[
            //           TextButton(
            //             child: Text('OK'),
            //             onPressed: () {
            //               Navigator.of(context).pop();
            //             },
            //           ),
            //         ],
            //       );
            //     },
            //   );
            // }
          },
        ),
      ],
    );
  }

  iconImage(String imagePath) {
    return Container(
      width: 15.0,
      height: 20.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  eligiblesList(eligibles) {
    if (eligibles.length > 2) {
      return Row(
        children: [
          for (String eligible in eligibles.sublist(0, 2))
            Text(
              '$eligible ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          Text(
            '...',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          for (String eligible in eligibles)
            Text(
              '$eligible ',
              style: TextStyle(
                color: Colors.grey,
              ),
            )
        ],
      );
    }
  }
}
