import 'package:erasmus_projects/models/user_model.dart';
import 'package:erasmus_projects/providers/drawer_active_screen.dart';
import 'package:erasmus_projects/screens/active_projects_screen/active_projects_screen.dart';
import 'package:erasmus_projects/screens/delete_account_screen.dart';
import 'package:erasmus_projects/screens/explore/explore_screen.dart';
import 'package:erasmus_projects/screens/favoutires_projects_screen.dart';
import 'package:erasmus_projects/screens/home_screen.dart';
import 'package:erasmus_projects/screens/publish_project_screen/publish_project_screen.dart';
import 'package:erasmus_projects/screens/rate_us.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key key,
    this.currentSelected,
//    this.screenId,
  }) : super(key: key);

  final String currentSelected;
  //final BuildContext screenId;

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List<ListItem> _list = [
    ListItem('Explore', ExploreScreen.id),
    ListItem('Publish Projects', PublishProjectScreen.id),
    ListItem('Active Projects', ActiveProjectsScreen.id),
    ListItem('Favourites Projects', FavouritesProjectsScreen.id),
    //ListItem(Icons.favorite, 'Favorites', Favorites.id),
    ListItem('Delete Account', DeleteAccountScreen.id),
    ListItem('Rate Us', RateUs.id),
  ];

  //String _currentSelected = 'Início';

  Widget _getListItemTile(BuildContext context, ListItem item) {
    return Consumer<DrawerActiveScreen>(
        builder: (context, screenActive, child) {
      return Container(
        height: 45.0,
        //margin: EdgeInsets.symmetric(vertical: 4),
        // color: item.screen == screenActive.screenName
        //     ? Colors.blue[100]
        //     : Colors.white,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 5.0,
              color: item.screen == screenActive.screenName
                  ? kYellowGold
                  : Colors.white,
            ),
          ),
        ),
        child: ListTile(
          //leading: Icon(item.icon),
          title: Text(item.name),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamedAndRemoveUntil(
            //     context, item.screen, (route) => false);
            Navigator.pushNamed(context, item.screen);
            screenActive.changeScreenName(item.screen);
          },
          //selected: item.screen == screenActive.screenName ? true : false,
        ),
      );
    });
  }

  getPrefsUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              //color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage('assets/images/bandeira.jpeg')),
            ),
            // currentAccountPicture: GestureDetector(
            //   child: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: Padding(
            //       padding: const EdgeInsets.all(4.0),
            //       child: Container(
            //         padding: EdgeInsets.all(4.0),
            //         decoration: new BoxDecoration(
            //           borderRadius:
            //               new BorderRadius.all(new Radius.circular(50.0)),
            //           border: new Border.all(
            //             color: kYellowGold,
            //             width: 2.0,
            //           ),
            //         ),
            //         child: CircleAvatar(
            //           radius: 30.0,
            //           backgroundImage: AssetImage('assets/images/profile.png'),
            //           backgroundColor: Colors.transparent,
            //         ),
            //       ),
            //     ),
            //   ),
            //   onTap: () {
            //     //Navigator.pushNamed(context, PublishProjectScreen.id);
            //   },
            // ),
            //accountName: Text('Doguinho'),
          ),
          for (var item in _list) _getListItemTile(context, item),
          // Text('Organization Name'),
          // Expanded(
          //     child: Align(
          //         alignment: Alignment.bottomLeft, child: Text('LOG OUT'))),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                title: FutureBuilder(
                    // future:
                    //     UserModel(email: kAuth.currentUser.email).getUserData(),
                    future: getPrefsUserName(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.data != null
                          ? Text(
                              snapshot.data,
                              //'Organization Name',
                              style: TextStyle(
                                color: Colors.blue[900],
                              ),
                            )
                          : Container();
                    }),
              ),
              Container(
                height: 45.0,
                child: ListTile(
                  title: Text(
                    'LOG OUT',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    kAuth.signOut();
                    Navigator.pop(context);
                    Navigator.pushNamed(context, HomeScreen.id);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                  child: Text(
                    'Powered by Oli Enterprise',
                    style: TextStyle(
                        color: kYellowGold, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class ListItem {
  ListItem(this.name, this.screen);

  String name;
  String screen;
}
