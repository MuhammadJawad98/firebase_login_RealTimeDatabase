import 'package:flutter/material.dart';
class DetailText extends StatefulWidget {
  String txt;
  IconData icon;

  DetailText({this.txt, this.icon});

  @override
  _DetailTextState createState() => _DetailTextState();
}

class _DetailTextState extends State<DetailText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(widget.icon,color: Colors.pink,),
        SizedBox(width: 20,),
        Text(widget.txt,style: TextStyle(color: Colors.grey,fontSize: 20),)
      ],),
    );
  }
}
