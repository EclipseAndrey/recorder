import 'package:flutter/material.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

const double appbarHeight = 56.0;

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool moreIsActive = false;

  MyAppBar({this.moreIsActive});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {},
              child: IconSvg(IconsSvg.menu,
                  width: 28, height: 21, color: cBackground)),
          widget.moreIsActive
              ? GestureDetector(
                  onTap: () {},
                  child: IconSvg(IconsSvg.more,
                      width: 30, height: 8, color: cBackground))
              : SizedBox(
                  width: 28,
                )
        ],
      ),
    );
  }
}
