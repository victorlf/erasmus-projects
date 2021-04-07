import 'package:erasmus_projects/providers/drawer_active_screen.dart';
import 'package:erasmus_projects/screens/home_screen.dart';
import 'package:erasmus_projects/screens/publish_project_screen.dart';
import 'package:erasmus_projects/screens/rate_us.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    ListItem('Publish Projects', PublishProjectScreen.id),
    //LisItem('Active Projects',),
    //ListItem(Icons.favorite, 'Favorites', Favorites.id),
    //ListItem(Icons.help, 'Help', Help.id),
    ListItem('Rate Us', RateUs.id),
  ];

  //String _currentSelected = 'Início';

  Widget _getListItemTile(BuildContext context, ListItem item) {
    return Consumer<DrawerActiveScreen>(
        builder: (context, screenActive, child) {
      return Container(
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                //color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage('assets/images/bandeira.jpeg')),
              ),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: new BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: kYellowGold,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  //Navigator.pushNamed(context, PublishProjectScreen.id);
                },
              ),
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
                    title: Text(
                      auth.currentUser.email,
                      //'Organization Name',
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'LOG OUT',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      auth.signOut();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, HomeScreen.id);
                    },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem {
  ListItem(this.name, this.screen);

  String name;
  String screen;
}
