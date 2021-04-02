import 'package:erasmus_projects/components/form_input.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class RegisterOrganizationScreen extends StatefulWidget {
  static const String id = "register_organization_sreen";

  @override
  _RegisterOrganizationScreenState createState() =>
      _RegisterOrganizationScreenState();
}

class _RegisterOrganizationScreenState
    extends State<RegisterOrganizationScreen> {
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
                        image: AssetImage("assets/images/Eramus.jpeg"),
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
                        child: Text(
                          "Organization Registration",
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
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
                FormInput(
                  title: "Organization Name",
                  inputHint: 'Enter Organization Name',
                ),
                FormInput(
                  title: "Organization PIC Number",
                  inputHint: 'Enter PIC Number',
                ),
                FormInput(
                  title: "Email",
                  inputHint: 'Enter Email',
                ),
                FormInput(
                  title: "Password",
                  inputHint: 'Enter Password',
                ),
                FormInput(
                  title: "Confirm Password",
                  inputHint: 'Enter Password',
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.blue[900]),
                  child: CheckboxListTile(
                    title: const Text(
                      'We do not have a PIC Number, we are an organization outside European Union.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: const Color(0xFF0D47A1),
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    activeColor: Colors.blue[900],
                    value: timeDilation != 1.0,
                    onChanged: (bool value) {
                      setState(() {
                        timeDilation = value ? 10.0 : 1.0;
                      });
                    },
                  ),
                ),
                Text(
                  "By creating the account you agree with the terms, conditions & policies. This is an unofficial app created by independents",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kYellowGold,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Create Account",
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
