// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:memo/models/word_model.dart';

class Theme {
  int id;
  String name;
  List<Word> words;
  Theme({
    required this.id,
    required this.name,
    required this.words,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'words': words.map((x) => x.toMap()).toList(),
    };
  }

  factory Theme.fromMap(Map<String, dynamic> map) {
    return Theme(
      id: map['id'] as int,
      name: map['name'] as String,
      words: List<Word>.from(
        map['words'].map<Word>(
          (x) => Word.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Theme.fromJson(String source) => Theme.fromMap(json.decode(source) as Map<String, dynamic>);
}
