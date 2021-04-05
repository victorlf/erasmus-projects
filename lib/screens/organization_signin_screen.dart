import 'package:erasmus_projects/components/form_input.dart';
import 'package:erasmus_projects/screens/explore/explore_screen.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrganizationSigninScreen extends StatefulWidget {
  static const String id = 'organization_signin_screen';

  @override
  _OrganizationSigninScreenState createState() =>
      _OrganizationSigninScreenState();
}

class _OrganizationSigninScreenState extends State<OrganizationSigninScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                          "Organization Sign In",
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
                  title: "Email",
                  inputHint: 'Enter Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                FormInput(
                  title: "Password",
                  inputHint: 'Enter Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (user != null) {
                        Navigator.pushNamed(context, ExploreScreen.id);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    "Login",
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
