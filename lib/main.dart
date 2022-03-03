import 'package:flutter/material.dart';
import 'components/image_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SelectNumber(),
    );
  }
}

class SelectNumber extends StatefulWidget {
  const SelectNumber({Key? key}) : super(key: key);

  @override
  State<SelectNumber> createState() => _SelectNumberState();
}

class _SelectNumberState extends State<SelectNumber> {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  SharedPreferences? prefs;

  int correctAns = 0;
  int score = 0;
  int ans = 0;

  @override
  void initState() {
    super.initState();
    loadScore();
  }

  saveScore(int newScore) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setInt("score", newScore);
  }

  loadScore() async {
    prefs = await SharedPreferences.getInstance();
    var myscore = prefs!.getInt("score")!;
    setState(() {
      score = myscore;
    });
  }

  Widget imageList(List<int> images) => Column(
      children: images
          .map((val) => ImageButton(
              correctAns: correctAns,
              val: val,
              onTap: (ans) {
                setState(() {
                  score += ans;
                  saveScore(score);
                });
              }))
          .toList());

  @override
  Widget build(BuildContext context) {
    numbers.shuffle();
    List<int> images = numbers.sublist(0, 3);
    correctAns = images[0];
    images.shuffle();

    return Scaffold(
      appBar: AppBar(title: const Text("Select the number")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Select the number $correctAns"),
            imageList(images),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Refresh")),
            Text("Score : $score"),
          ],
        ),
      ),
    );
  }
}
