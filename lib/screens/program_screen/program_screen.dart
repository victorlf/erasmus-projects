import 'package:erasmus_projects/components/info_data.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgramScreen extends StatelessWidget {
  static const String id = 'program_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/Brazil.jpg"),
                      ),
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
                                "Rethinking – Reconnecting – Rebuilding (Title)",
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
                              child: FaIcon(FontAwesomeIcons.heart),
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
                  info: 'Bridges for Trainers (BfT)',
                ),
                SizedBox(
                  height: 10.0,
                ),
                InfoData(
                  title: 'Dates',
                  info: '17-20 November 2020',
                ),
                SizedBox(
                  height: 10.0,
                ),
                InfoData(
                  title: 'Venue',
                  info: 'Online, Romania',
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
                    Text(
                      'Portugal',
                      style: TextStyle(
                        color: Colors.blue[900],
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Text(
                      'England',
                      style: TextStyle(
                        color: Colors.blue[900],
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Text(
                      'USA',
                      style: TextStyle(
                        color: Colors.blue[900],
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Text(
                      'Ireland',
                      style: TextStyle(
                        color: Colors.blue[900],
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Text(
                      'Turkey',
                      style: TextStyle(
                        color: Colors.blue[900],
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Text(
                      'Peru',
                      style: TextStyle(
                        color: Colors.blue[900],
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Text(
                      'Argentina',
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
                  info: '28th September 2020',
                ),
                SizedBox(
                  height: 10.0,
                ),
                InfoData(
                  title: 'Type',
                  info: 'Youth Exchanges',
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
                    Text(
                      'BfT serves as a platform to contribute to exploring the next steps to be undertaken in the ETS development and to reflect on what role Erasmus+ Youth Programme and the European Solidarity Corps could play in this. BfT takes place every two years and is a conference concept bringing together experienced trainers, other training providers, and Erasmus+ Youth Programme and European Solidarity Corps NA/SALTO RC staff working with trainers / trainer pools to reflect on trends and core issues in the youth field and effects on the work of trainers. In 2020, trainers and training providers with existing training strategies for trainers at national or international level are invited to join the first online edition of Bridges for Trainers and explore the changes that the field went through in the past months – mostly due to the COVID-19 crisis, as well as what is ahead of us (role of training, new programmes, change of learning spaces and approaches, etc.).',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                InfoData(
                  title: 'Infopack',
                  info: 'Download',
                ),
                SizedBox(
                  height: 10.0,
                ),
                InfoData(
                  title: 'Casts',
                  info:
                      'This project is financed by the Erasmus+ Youth Programme.',
                ),
                SizedBox(
                  height: 10.0,
                ),
                InfoData(
                  title: 'Contact',
                  info: 'email@email.com',
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Apply",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
