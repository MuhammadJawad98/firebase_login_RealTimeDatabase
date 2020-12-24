import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/Fragments/Profile/components/Overlay.dart';

class CustomImage extends StatelessWidget {
  String imgUrl;

  //
  CustomImage({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(children: [
      Container(
        child: Stack(children: [
          ClipPath(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage((imgUrl == null)
                          ? 'https://images.unsplash.com/photo-1608768025308-a713c513952a?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'
                          : imgUrl))),
            ),
            clipper: CustomClipPath(),
          ),
          new OverLayColor(
            posLeft: 0,
            posTop: 0,
            height: 250,
            opacity: 0.6,
            path: OverlayClipPath(),
          ),
          new OverLayColor(
            posLeft: 0,
            posTop: 0,
            height: 250,
            opacity: 0.4,
            path: OverLay_ClipPath(),
          ),
        ]),
      ),
      new Positioned(
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1533227268428-f9ed0900fb3b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTd8fG1hbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60'),
            radius: 50,
          ),
        ),
        left: width * 0.10,
        bottom: 0,
      ),
    ]);
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OverlayClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OverLay_ClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
