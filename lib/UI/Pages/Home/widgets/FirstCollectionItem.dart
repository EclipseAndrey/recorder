import 'package:flutter/material.dart';
import 'package:recorder/Style.dart';

import 'package:recorder/generated/l10n.dart';

class CollectionItemOne extends StatefulWidget {
  double height;
  double width;
  String img;
  String title;
  int audioQuantity;
  String timeOfCollection;
  int length;
  Function onTap;

  CollectionItemOne(
      {this.height,
      this.width,
      this.img,
      this.title,
      this.audioQuantity,
      this.timeOfCollection,
      @required this.length,
      @required this.onTap});
  _CollectionItemOneState createState() => _CollectionItemOneState();
}

class _CollectionItemOneState extends State<CollectionItemOne> {
  bool longTap = false;
  @override
  Widget build(BuildContext context) {
    return widget.length < 1
        ? GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 20,
                      color: Color.fromRGBO(0, 0, 0, 0.25))
                ],
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(113, 165, 159, 0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      S.of(context).titleOfEmptyCollection,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        // letterSpacing: 1.01
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 1.5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: cBackground, width: 1))),
                        child: Text(
                          S.of(context).add,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
            },
            onLongPressStart: (i) {
              longTap = true;
              setState(() {});
            },
            onLongPressEnd: (i) {
              longTap = false;
              if (widget.onTap != null) {
                widget.onTap();
              }
              setState(() {});
            },
            onTapDown: (i) {
              longTap = true;
              setState(() {});
            },
            onTapUp: (e) {
              longTap = false;
              setState(() {});
            },
            onPanStart: (i) {
              longTap = true;
              setState(() {});
            },
            onPanEnd: (e) {
              longTap = false;
              setState(() {});
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(alignment: Alignment.bottomLeft, children: [
                Container(
                  width: widget.width,
                  height: widget.height,
                  color: cBlack,
                  child: Image(
                      image: NetworkImage("${widget.img}"), fit: BoxFit.cover),
                ),
                Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromRGBO(0, 0, 0, 0),
                        Color.fromRGBO(0, 0, 0, 0),
                        Color.fromRGBO(69, 69, 69, 1)
                      ])),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: widget.width / 2.3,
                              child: Text("${widget.title}",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                            ),
                            Container(
                              width: widget.width / 2.4,
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("${widget.audioQuantity} аудио",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  Text("${widget.timeOfCollection} часа",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: longTap ? 0.2 : 0.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 240 / 896,
                    width: MediaQuery.of(context).size.width * 183 / 414,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              ]),
            ));
  }
}
