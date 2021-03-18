import 'package:flutter/material.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/generated/l10n.dart';

class SmallCollectionItem extends StatefulWidget {
  double height;
  double width;
  String img;
  String title;
  String audioQuantity;
  String timeOfCollection;
  int length;
  Color contColor;
  Function onTap;
  String text;

  SmallCollectionItem(
      {this.height,
      this.width,
      this.img,
      this.title,
      this.audioQuantity,
      this.timeOfCollection,
      @required this.text,
      @required this.length,
      @required this.contColor,
      @required this.onTap});

  @override
  _SmallCollectionItemState createState() => _SmallCollectionItemState();
}

class _SmallCollectionItemState extends State<SmallCollectionItem> {
  @override
  Widget build(BuildContext context) {
    return widget.length < 2
        ? GestureDetector(
            onTap: () {},
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: widget.contColor),
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.5),
                  decoration: BoxDecoration(
                      border: widget.length == 0
                          ? null
                          : Border(
                              bottom:
                                  BorderSide(color: cBackground, width: 1))),
                  child: Text(
                    "${widget.text}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(alignment: Alignment.bottomLeft, children: [
                Container(
                  width: widget.width,
                  height: widget.height,
                  color: cBlack,
                  child: Image(
                      image: NetworkImage("${widget.img}"), fit: BoxFit.fill),
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
                    ))
              ]),
            ));
  }
}
