import 'package:flutter/material.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';
import 'package:recorder/generated/l10n.dart';

class OldPerson extends StatefulWidget {
  @override
  _OldPersonState createState() => _OldPersonState();
}

class _OldPersonState extends State<OldPerson> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            background(
              child: header(),
              body: body()
            ),
          ],
        ),
      ),
    );
  }

  Widget background({Widget child, Widget body}) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: IconSvg(
                id: IconsSvg.backEllipse,
                width: MediaQuery.of(context).size.width,
                color: cBlueSoso),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 414 / 369,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: child ?? SizedBox(),
                    ),
                  ),

                ),
                Container(
                    height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.width * 414/ 369),
                    child: body??SizedBox())
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    return RichText(
      text: TextSpan(
          text: S.of(context).app_name,
          style: TextStyle(
              fontSize: 48,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700),
          children: [
            TextSpan(
                text: "\n${S.of(context).slogan}",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400))
          ]),
      textAlign: TextAlign.end,
    );
  }


  Widget body(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: cBackground,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0,4),
                blurRadius: 7,
                spreadRadius: 0,
                color: Color.fromRGBO(0,0,0,0.11)
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 21),
            child: Text(S.of(context).hello_old, style: TextStyle(fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 24, color: cBlack),),
          ),
        ),

        IconSvg(id: IconsSvg.heart, width: 45, color: cOrange),
        SizedBox(),
        SizedBox(),
        Container(
          decoration: BoxDecoration(
              color: cBackground,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,4),
                    blurRadius: 7,
                    spreadRadius: 0,
                    color: Color.fromRGBO(0,0,0,0.11)
                )
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 21),
            child: Text(S.of(context).hello_old_desc,  textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 14, color: cBlack),),
          ),
        ),
      ],
    );
  }


}
