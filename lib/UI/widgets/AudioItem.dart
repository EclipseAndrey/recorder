import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class AudioItemWidget extends StatefulWidget {
  AudioItem item;
  AudioItemWidget({@required this.item});
  @override
  _AudioItemWidgetState createState() => _AudioItemWidgetState();
}

class _AudioItemWidgetState extends State<AudioItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: cBackground,
          border: Border.all(color: Color.fromRGBO(58, 58, 85, 0.2)),
          borderRadius: BorderRadius.circular(41)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconSvg(IconsSvg.play, width: 50, height: 50),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 18),
            child: Container(
              width: MediaQuery.of(context).size.width - 162,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.item.name}',
                    style: TextStyle(
                        color: cBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${widget.item.time.inMinutes} мин',
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
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: IconSvg(IconsSvg.moreAudios, width: 18, color: cBlack)),
        ],
      ),
    );
  }
}
