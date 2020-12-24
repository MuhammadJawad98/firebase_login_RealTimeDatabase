import 'package:flutter/material.dart';
class ProfileText extends StatefulWidget {
  int numbers;
  String text;

  ProfileText({this.numbers, this.text});

  @override
  _ProfileTextState createState() => _ProfileTextState();
}

class _ProfileTextState extends State<ProfileText> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            widget.numbers.toString(),
            style: TextStyle(color: Colors.pink,fontSize: 22),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.text,
            style: TextStyle(color: Colors.grey,fontSize: 18),
          ),
        ],
      ),
    );
  }
}
