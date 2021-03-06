import 'package:erasmus_projects/providers/drawer_active_screen.dart';
import 'package:erasmus_projects/screens/active_projects_screen/active_projects_screen.dart';
import 'package:erasmus_projects/screens/delete_account_screen.dart';
import 'package:erasmus_projects/screens/drawer/main_drawer.dart';
import 'package:erasmus_projects/screens/explore/explore_screen.dart';
import 'package:erasmus_projects/screens/favoutires_projects_screen.dart';
import 'package:erasmus_projects/screens/home_screen.dart';
import 'package:erasmus_projects/screens/organization_signin_screen.dart';
import 'package:erasmus_projects/screens/program_screen/program_screen.dart';
import 'package:erasmus_projects/screens/publish_project_screen/edit_project_screen.dart';
import 'package:erasmus_projects/screens/publish_project_screen/publish_project_screen.dart';
import 'package:erasmus_projects/screens/rate_us.dart';
import 'package:erasmus_projects/screens/register_organization_screen/register_organization_screen.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await kInitialization;
  User user = await getCurrentUser();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DrawerActiveScreen(
            ExploreScreen.id,
          ),
        )
      ],
      child: MyApp(user),
    ),
  );
}

class MyApp extends StatelessWidget {
  final user;
  MyApp(this.user);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Erasmus Projects',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: user == null ? HomeScreen.id : ExploreScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          ExploreScreen.id: (context) => ExploreScreen(),
          RegisterOrganizationScreen.id: (context) =>
              RegisterOrganizationScreen(),
          OrganizationSigninScreen.id: (context) => OrganizationSigninScreen(),
          ProgramScreen.id: (context) => ProgramScreen(),
          PublishProjectScreen.id: (context) => PublishProjectScreen(),
          RateUs.id: (context) => RateUs(),
          ActiveProjectsScreen.id: (context) => ActiveProjectsScreen(),
          EditProjectScreen.id: (context) => EditProjectScreen(),
          DeleteAccountScreen.id: (context) => DeleteAccountScreen(),
          FavouritesProjectsScreen.id: (context) => FavouritesProjectsScreen(),
        });
  }
}
