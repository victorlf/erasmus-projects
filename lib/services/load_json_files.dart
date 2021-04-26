import 'package:flutter/services.dart';

Future<String> loadJsonCountries() async =>
    await rootBundle.loadString('assets/countries.json');
