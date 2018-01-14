import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.height, this.tag }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double height;
  final String tag;

  Widget build(BuildContext context) {
    return new Hero(
      tag: tag,
      child: new GestureDetector(
        onTap: onTap,
        child: new Image.network(photo, height: height)
      ),
    );
  }
}