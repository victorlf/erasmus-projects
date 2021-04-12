import 'package:erasmus_projects/screens/program_screen.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String country;
  final String beginDate;
  final String endDate;
  final List eligibles;

  InfoCard({
    this.title,
    this.country,
    this.beginDate,
    this.endDate,
    this.eligibles,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  title,
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
                      country,
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
                      '${beginDate} - ${endDate}',
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
                    for (String eligible in eligibles)
                      Text(
                        eligible,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    // Text(
                    //   'Croatia, Estonia, France, Italy',
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: -20.0,
            top: 20,
            child: FutureBuilder(
                future: downloadURLExample(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //if (!snapshot.hasData) return Center(child: kProgressCircle);
                  if (!snapshot.hasData) return Container();
                  return snapshot.data;
                }),
          ),
          Positioned(
            right: -10.0,
            top: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProgramScreen.id);
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

  Future downloadURLExample() async {
    String downloadURL =
        await kFirebaseStorage.ref('flags/${country}.jpg').getDownloadURL();

    return CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage(downloadURL),
      backgroundColor: Colors.transparent,
    );
  }
}
