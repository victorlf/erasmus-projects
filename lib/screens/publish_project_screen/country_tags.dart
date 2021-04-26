import 'dart:convert';

import 'package:erasmus_projects/services/load_json_files.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:flutter/material.dart';

class ProjectService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<TagItem>> getProjects(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <TagItem>[
      TagItem(name: 'Self-Care', position: 1),
      TagItem(name: 'Ukraine', position: 2),
    ]
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

/// LanguageService
class CountryService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<TagItem>> getCountries(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);

    var countries = await loadJsonCountries();
    var countriesMap = jsonDecode(countries);

    List<TagItem> tagItemList = [];
    for (int i = 0; i < 243; i++) {
      tagItemList.add(TagItem(name: countriesMap[i]['name'], position: i));
      //print(countriesMap['name']);
    }

    return tagItemList
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // return <TagItem>[
    //   TagItem(name: 'Brazil', position: 1),
    //   TagItem(name: 'Portugal', position: 2),
    //   TagItem(name: 'France', position: 3),
    //   TagItem(name: 'Germany', position: 4),
    //   TagItem(name: 'United States', position: 5),
    //   TagItem(name: 'Argentina', position: 6),
    // ]
    //     .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
    //     .toList();
  }
}

/// Language Class
class TagItem extends Taggable {
  ///
  final String name;

  ///
  final int position;

  /// Creates Language
  TagItem({
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
