import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:flutter/material.dart';

/// LanguageService
class CountryService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<Country>> getCountries(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <Country>[
      Country(name: 'Brazil', position: 1),
      Country(name: 'Portugal', position: 2),
      Country(name: 'France', position: 3),
      Country(name: 'Germany', position: 4),
      Country(name: 'United States', position: 5),
      Country(name: 'Argentina', position: 6),
    ]
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

/// Language Class
class Country extends Taggable {
  ///
  final String name;

  ///
  final int position;

  /// Creates Language
  Country({
    @required this.name,
    @required this.position,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,\n
    "position": $position\n
  }''';
}
