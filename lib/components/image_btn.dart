import 'package:flutter/material.dart';

typedef ImangeButtononTap = void Function(int score);

class ImageButton extends StatelessWidget {
  int correctAns = 0;
  int val = 0;
  ImangeButtononTap onTap;

  ImageButton(
      {Key? key,
      required this.correctAns,
      required this.val,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var message = "";
        var msgColor = Colors.red;
        var score = 0;
        if (correctAns == val) {
          message = "Your answer is correct.";
          msgColor = Colors.green;
          score += 10;
        } else {
          message = "Your answer is incorrect.";
          msgColor = Colors.red;
        }

        onTap(score);

        final snackBar = SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
          backgroundColor: msgColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }, // Handle your callback.
      child: Ink(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$val.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
