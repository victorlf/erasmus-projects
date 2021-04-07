import 'package:erasmus_projects/screens/explore/explore_screen.dart';
import 'package:erasmus_projects/screens/organization_signin_screen.dart';
import 'package:erasmus_projects/screens/register_organization_screen/register_organization_screen.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.vertical(
                bottom: Radius.elliptical(350.0, 100.0),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/Eramus.jpeg')),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ExploreScreen.id,
              );
            },
            child: Text(
              "EXPLORE...",
              style: TextStyle(
                color: kYellowGold,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                OrganizationSigninScreen.id,
              );
            },
            child: Text(
              "Organization Sign in",
              style: TextStyle(
                color: kYellowGold,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RegisterOrganizationScreen.id,
              );
            },
            child: Text(
              'Register Organization',
              style: TextStyle(
                color: kYellowGold,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                child: Text(
                  'Powered by Oli Enterprise',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
