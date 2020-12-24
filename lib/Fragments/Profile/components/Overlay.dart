import 'package:flutter/material.dart';

import 'CutomImg.dart';
class OverLayColor extends StatefulWidget {
  double posLeft,posTop,opacity,height;
  CustomClipper path;


  OverLayColor(
      {this.posLeft, this.posTop, this.opacity, this.height, this.path});

  @override
  _OverLayColorState createState() => _OverLayColorState();
}

class _OverLayColorState extends State<OverLayColor> {
  @override
  Widget build(BuildContext context) {
    return       new Positioned(
      left: widget.posLeft,
      top: widget.posTop,
      child: Opacity(
        opacity: widget.opacity,
        child: ClipPath(
          clipper: widget.path,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: widget.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.pink[300], Colors.pink[200]])),
          ),
        ),
      ),
    );
  }
}
