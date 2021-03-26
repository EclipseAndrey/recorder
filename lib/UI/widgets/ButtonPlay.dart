import 'package:flutter/material.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class ButtonPlay extends StatefulWidget {
  final Color colorPlay;
  final Function onTap;
  ButtonPlay({@required this.colorPlay, this.onTap});
  @override
  _ButtonPlayState createState() => _ButtonPlayState();
}

class _ButtonPlayState extends State<ButtonPlay> {
  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap != null ? widget.onTap() : null;
        tap = !tap;
        setState(() {});
      },
      // onLongPressStart: (i) {
      //   tap = true;
      //   setState(() {});
      // },
      // onLongPressEnd: (i) {
      //   tap = false;
      //   setState(() {});
      // },
      // onTapDown: (i) {
      //   tap = true;
      //   setState(() {});
      // },
      // onTapUp: (e) {
      //   tap = false;
      //   setState(() {});
      // },
      // onPanStart: (i) {
      //   tap = true;
      //   setState(() {});
      // },
      // onPanEnd: (e) {
      //   tap = false;
      //   setState(() {});
      // },
      child: IconSvg(tap ? IconsSvg.pause : IconsSvg.play,
          width: 50, height: 50, color: widget.colorPlay),
    );
  }
}
