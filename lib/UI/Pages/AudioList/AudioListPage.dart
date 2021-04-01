import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import 'package:recorder/UI/widgets/AudioItem.dart';
import 'package:recorder/UI/widgets/AudioPreviewGenerate.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';
import 'package:recorder/generated/l10n.dart';

class AudioListPage extends StatefulWidget {
  List<AudioItem> playlist = [
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
    AudioItem(name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 8000)),
  ];

  @override
  _AudioListPageState createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackground.withOpacity(0.0),
        appBar: MyAppBar(
          buttonMore: true,
          buttonBack: false,
          buttonMenu: true,
          top: 25,
          height: 100,
          child: Container(
            child: Column(
              children: [
                Text(
                  S.of(context).audio_appbar,
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontFamily: fontFamilyMedium,
                      letterSpacing: 2),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  S.of(context).audio_appbar_subtitle,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: fontFamilyMedium,
                      letterSpacing: 2),
                )
              ],
            ),
          ),
        ),
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
                playlistPreview(widget.playlist)
              ],
            )),
      ),
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
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: cBlueSoso,
                        fontFamily: fontFamilyMedium),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 9,
            ),
            GestureDetector(
              child: IconSvg(
                IconsSvg.audioRepeat,
                width: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget playlistInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.playlist.length} ${S.of(context).audio}',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cBackground,
              fontFamily: fontFamilyMedium),
        ),
        Text(
          '10:30 часов',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: cBackground,
              fontFamily: fontFamilyMedium),
        )
      ],
    );
  }

  Widget playlistPreview(List<AudioItem> list, {Color colorPlay}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 12),
      child: AudioPreviewGenerate(
          items: list,
          colorPlay: cBlue,
          currentIndex: currentIndex,
          onChange: (index) {
            currentIndex = index;
            setState(() {});
            print('index $index');
          }),
    );
  }
}
