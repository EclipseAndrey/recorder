import 'package:flutter/material.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

const double appbarHeight = 56.0;

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool buttonMore;
  final bool buttonMenu;
  final bool buttonBack;
  final double height;
  final Widget child;
  final double padding;
  final double top;

  MyAppBar({
    this.buttonMore = false,
    this.buttonBack = true,
    this.buttonMenu = true,
    this.height = 64,
    this.child,
    this.padding = 5,
    this.top = 0,
  });

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.padding, right: widget.padding, top: widget.top),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.buttonBack
                ? Container(
                    decoration: BoxDecoration(
                        color: cBackground,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconSvg(IconsSvg.back, width: 27, height: 27),
                    ),
                  )
                : widget.buttonMenu
                    ? GestureDetector(
                        behavior: HitTestBehavior.deferToChild,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 11),
                          child: IconSvg(IconsSvg.menu,
                              width: 28, height: 21, color: cBackground),
                        ))
                    : SizedBox(),
            widget.child != null ? widget.child : SizedBox(),
            widget.buttonMore
                ? GestureDetector(
                    onTap: () {},
                    child: IconSvg(IconsSvg.more,
                        width: 41, height: 8, color: cBackground))
                : SizedBox(
                    width: 28,
                  )
          ],
        ),
      ),
    );
  }
}
