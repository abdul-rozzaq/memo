// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Word {
  int id;
  String korean;
  String uzbek;

  Word({
    required this.id,
    required this.korean,
    required this.uzbek,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'korean': korean,
      'uzbek': uzbek,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'] as int,
      korean: map['korean'] as String,
      uzbek: map['uzbek'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source) as Map<String, dynamic>);
}
