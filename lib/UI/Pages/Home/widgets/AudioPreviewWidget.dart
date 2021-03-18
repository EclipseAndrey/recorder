import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';
import 'package:recorder/generated/l10n.dart';

class AudioPreview extends StatefulWidget {
  List<AudioItem> items;

  AudioPreview({@required this.items});
  @override
  _AudioPreviewState createState() => _AudioPreviewState();
}

class _AudioPreviewState extends State<AudioPreview> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 4,
          decoration: BoxDecoration(
              color: cBackground,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                    blurRadius: 24,
                    color: Color.fromRGBO(0, 0, 0, 0.15))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 11),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 2.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).audios,
                        style: TextStyle(
                            color: cBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        S.of(context).open_all,
                        style: TextStyle(
                            color: cBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                audiosPreview(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget audiosPreview(BuildContext context) {
    return widget.items.length == 0
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 57.0),
                child: Text(
                  S.of(context).text_of_empty_audios,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                      color: cBlack.withOpacity(0.5)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: IconSvg(IconsSvg.audioArrow, width: 60, height: 60),
              )
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Column(
              children: List.generate(
                  widget.items.length < 5 ? widget.items.length : 5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromRGBO(58, 58, 85, 0.2)),
                        borderRadius: BorderRadius.circular(41)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconSvg(IconsSvg.play, width: 50, height: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 18),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 162,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.items[index].name}',
                                  style: TextStyle(
                                      color: cBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${widget.items[index].time} мин',
                                  style: TextStyle(
                                      color: cBlack.withOpacity(0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: IconSvg(IconsSvg.moreAudios,
                                width: 18, color: cBlack)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
