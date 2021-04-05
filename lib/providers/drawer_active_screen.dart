import 'package:flutter/foundation.dart';

class DrawerActiveScreen extends ChangeNotifier {
  String _screenName;

  DrawerActiveScreen(this._screenName);

  String get screenName => _screenName;

  void changeScreenName(String newName) {
    _screenName = newName;

    notifyListeners();
  }
}
