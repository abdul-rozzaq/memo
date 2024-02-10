import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/theme.dart' as models;

class AppProvider extends ChangeNotifier {
  String host = 'https://memo.pythonanywhere.com/';

  List<models.Theme> themes = [];

  bool isLoaded = false;

  Future loadWords() async {
    Response response = await get(Uri.parse('$host/api/'));
    List jsonData = json.decode(utf8.decode(response.bodyBytes)) ;

    themes = List.from(jsonData.map((e) => models.Theme.fromMap(e)));

    isLoaded = true;

    notifyListeners();
  }
}
