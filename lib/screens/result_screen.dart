import 'package:flutter/material.dart';
import 'package:memo/models/word_model.dart';
import 'package:memo/screens/home_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.incorrectAnswers, required this.words});

  final List<List<dynamic>> incorrectAnswers;
  final List<Word> words;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (x) => const HomeScreen(),
              ),
              (route) => false),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Result',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey[50],
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
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                color: Colors.green[100],
                                strokeCap: StrokeCap.round,
                                strokeWidth: 10,
                                value: 1,
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                color: Colors.green,
                                strokeCap: StrokeCap.round,
                                strokeWidth: 10,
                                value: 1 - widget.incorrectAnswers.length / widget.words.length,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                              child: Text(
                            '${((1 - widget.incorrectAnswers.length / widget.words.length) * 100).toInt()} %',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.words.length.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${widget.words.length - widget.incorrectAnswers.length}",
                              style: const TextStyle(color: Colors.green),
                            ),
                            const Text(
                              'Correct',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              widget.incorrectAnswers.length.toString(),
                              style: const TextStyle(color: Colors.red),
                            ),
                            const Text(
                              'Wrong',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => getWidget(index),
              itemCount: widget.incorrectAnswers.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget getWidget(int index) {
    Word word = widget.incorrectAnswers[index][0];

    String wrongAnswer = widget.incorrectAnswers[index][1];

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .7,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, 1),
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            word.korean,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            word.uzbek,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
          Text(
            wrongAnswer,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
