import 'package:flutter/material.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/widgets/Background.dart';
import 'package:recorder/UI/widgets/MainPanel.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class General extends StatefulWidget {
  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {

  Color colorActive = cBlue;
  Color colorInactive = cBlack.withOpacity(0.8);
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Background()),
        Align(
          alignment: Alignment.bottomCenter,
          child: MainPanel(
            currentIndex: currentIndex,
            onChacge: (index){
              currentIndex = index;
              setState(() {

              });
              print("index $index");
            },
            items: [
              ItemMainPanel(icon: IconSvg(IconsSvg.home, width: 24, height: 24, color: colorActive), iconInactive: IconSvg(IconsSvg.home, color: colorInactive, width: 24, height: 24), text: Text("Главная", style: TextStyle(color: cBlue, fontSize: 10),),),
              ItemMainPanel(icon: IconSvg(IconsSvg.category, width: 24, height: 24, color: colorActive), iconInactive: IconSvg(IconsSvg.category, width: 24, height: 24, color: colorInactive), text: Text("Подборки", style: TextStyle(color: cBlue, fontSize: 10),),),
              ItemMainPanel(colorActive: cOrange, colorInactive: cOrange, icon: Container(
                  decoration: BoxDecoration(
                    color: cOrange,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconSvg(IconsSvg.voice, width: 24, height: 24),
                  )), text: Text("Запись", style: TextStyle(color: cBlue, fontSize: 10),),),
              ItemMainPanel(icon: IconSvg(IconsSvg.paper, width: 24, height: 24, color: colorActive), iconInactive:  IconSvg(IconsSvg.paper, width: 24, height: 24, color: colorInactive), text: Text("Аудиозаписи", style: TextStyle(color: cBlue, fontSize: 10),),),
              ItemMainPanel(icon: IconSvg(IconsSvg.profile, width: 24, height: 24, color: colorActive), iconInactive: IconSvg(IconsSvg.profile, width: 24, height: 24,color: colorInactive), text: Text("Профиль", style: TextStyle(color: cBlue, fontSize: 10),),),

            ],

          ),
        )
      ],
    );
  }
}
