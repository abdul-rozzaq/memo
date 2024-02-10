import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memo/models/word_model.dart';
import 'package:memo/screens/result_screen.dart';

import '../models/theme.dart' as models;

class ExaminePage extends StatefulWidget {
  final models.Theme theme;

  const ExaminePage({
    super.key,
    required this.theme,
  });

  @override
  ExaminePageState createState() => ExaminePageState();
}

class ExaminePageState extends State<ExaminePage> {
  List<Word> words = [];
  List<String> answers = [];
  List<List<dynamic>> incorrectWords = [];

  late Timer timer;

  int time = 300;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double percent = time / 300;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.theme.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: widget.theme.words.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Ink(
                    width: size.width * .7,
                    padding: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -35),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            height: 80.0,
                            width: 80.0,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      color: Colors.blue[50],
                                      strokeCap: StrokeCap.round,
                                      strokeWidth: 5,
                                      value: 1,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                      strokeCap: StrokeCap.round,
                                      strokeWidth: 5,
                                      value: percent,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Center(
                                    child: Text(
                                  '$time s',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(height: 30),
                        Text(
                          words[index].korean,
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${index + 1} / ${words.length}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ...answers.map(
                    (e) => InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => nextQuestion(e),
                      child: Container(
                        width: size.width * .8,
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.black26,
                          ),
                        ),
                        child: Text('${['A', 'B', 'C', 'D'][answers.indexOf(e)]}) ${e.capitalize()}'),
                      ),
                    ),
                  )
                ],
              ),
            )
          : const Center(child: Text('So\'zlar mavjud emas')),
    );
  }

  void getAnswers() {
    String realAnswer = words[index].uzbek;

    answers = [realAnswer];

    while (answers.length < 4) {
      int index = Random().nextInt(words.length);
      Word word = words[index];
      if (!answers.contains(word.uzbek)) {
        answers.add(word.uzbek);
      }
    }

    answers.shuffle();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    words = [...widget.theme.words];

    words.shuffle();

    getAnswers();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time != 0) {
        setState(() {
          time -= 1;
        });
      } else {
        timer.cancel();

        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void nextQuestion(String e) {
    if (words[index].uzbek != e) {
      incorrectWords.add([words[index], e]);
    }

    if (index != words.length - 1) {
      index += 1;
      getAnswers();
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (x) => ResultScreen(incorrectAnswers: incorrectWords, words: words,)), (route) => false);
    }
  }
}

extension StringCapitalization on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
