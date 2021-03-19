import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/widgets/AudioItem.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';
import 'package:recorder/generated/l10n.dart';

class AudioLisPage extends StatefulWidget {
  List<AudioItem> playlist = [
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
  ];

  @override
  _AudioLisPageState createState() => _AudioLisPageState();
}

class _AudioLisPageState extends State<AudioLisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground.withOpacity(0.0),
      appBar: MyAppBar(moreIsActive: false),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 43,
              ),
              Container(
                padding: EdgeInsets.only(left: 25.0, right: 19.0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [playlistInfo(), playlistButton(context)],
                ),
              ),
              SizedBox(
                height: 33,
              ),
              playlistPreview()
            ],
          )),
    );
  }

  Container playlistButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: cBackground.withOpacity(0.5)),
      child: GestureDetector(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  color: cBackground, borderRadius: BorderRadius.circular(50)),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: IconSvg(IconsSvg.play,
                          width: 38, color: Color.fromRGBO(140, 132, 226, 1))),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    S.of(context).play_all,
                    style: playlistPanelTextStyle(isButton: true),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 9,
            ),
            GestureDetector(
              child: IconSvg(
                IconsSvg.audiosRepeat,
                width: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget playlistPreview() {
    return Column(
        children: List.generate(widget.playlist.length, (index) {
      return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AudioItemWidget(
            item: widget.playlist[index],
          ));
    }));
  }

  Widget playlistInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.playlist.length} ${S.of(context).audio}',
          style: playlistPanelTextStyle(isButton: false),
        ),
        Text(
          '10:30 часов',
          style: playlistPanelTextStyle(isButton: false),
        )
      ],
    );
  }
}
