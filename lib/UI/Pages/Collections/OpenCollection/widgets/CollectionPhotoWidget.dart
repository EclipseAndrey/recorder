import 'package:flutter/material.dart';
import 'package:recorder/Models/CollectionModel.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';
import 'package:recorder/generated/l10n.dart';

import '../../../../../Style.dart';

class CollectionPhotoWidget extends StatefulWidget {
  final CollectionItem item;
  CollectionPhotoWidget({@required this.item});
  @override
  _CollectionPhotoWidgetState createState() => _CollectionPhotoWidgetState();
}

class _CollectionPhotoWidgetState extends State<CollectionPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(alignment: Alignment.bottomLeft, children: [
              Container(
                width: MediaQuery.of(context).size.width * 382 / 414,
                height: MediaQuery.of(context).size.height * 240 / 896,
                color: cBlack,
                child: Image(
                    image: NetworkImage(widget.item.image), fit: BoxFit.fill),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 382 / 414,
                height: MediaQuery.of(context).size.height * 240 / 896,
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
              Container(
                width: MediaQuery.of(context).size.width * 382 / 414,
                height: MediaQuery.of(context).size.height * 240 / 896,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 27.0, top: 19, bottom: 16, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.item.publicationDate,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.item.audioQuantity} аудио',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                Text('${widget.item.timeOfCollection} минут',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 168 / 414,
                            height:
                                MediaQuery.of(context).size.height * 46 / 896,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: cBackground.withOpacity(0.16)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.83),
                              child: Row(
                                children: [
                                  IconSvg(IconsSvg.play,
                                      width: 38.33,
                                      height: 38.33,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.8)),
                                  SizedBox(width: 7),
                                  Text(
                                    S.of(context).play_all,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
