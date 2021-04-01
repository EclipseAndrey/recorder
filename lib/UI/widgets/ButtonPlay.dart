import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class ButtonPlay extends StatefulWidget {
  final Color colorPlay;
  final AudioItem item;
  final int index;
  final int currentIndex;
  final Function(int index) onChange;

  ButtonPlay(
      {@required this.colorPlay,
      this.item,
      this.index,
      this.currentIndex,
      this.onChange});
  @override
  _ButtonPlayState createState() => _ButtonPlayState();
}

class _ButtonPlayState extends State<ButtonPlay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.index == widget.currentIndex
            ? widget.onChange(null)
            : widget.onChange != null
                ? widget.onChange(widget.index)
                : null;
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
      child: IconSvg(
          widget.index == widget.currentIndex
              ? widget.item.activeIcon
              : widget.item.inActiveIcon ?? widget.item.activeIcon,
          width: 50,
          height: 50,
          color: widget.colorPlay),
    );
  }
}
