import 'package:flutter/material.dart';
import 'package:recorder/Models/ProfileModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/AudioList/AudioListPage.dart';
import 'package:recorder/UI/Pages/Collections/CollectionsPage.dart';
import 'package:recorder/UI/Pages/Profile/ProfilePage.dart';
import 'package:recorder/UI/Pages/Record/RecordPage.dart';
import 'package:recorder/UI/Pages/Subscription/SubscritionPage.dart';
import 'package:recorder/UI/widgets/Background.dart';
import 'package:recorder/UI/widgets/MainPanel.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

import 'Pages/Collections/OpenCollection/OpenCollection.dart';
import 'Pages/Home/HomePage.dart';

class General extends StatefulWidget {
  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  Color colorActive = cBlue;
  Color colorInactive = cBlack.withOpacity(0.8);
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  setPage(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Background(
                color: currentIndex == 1
                    ? cSwamp
                    : currentIndex == 3
                        ? cBlue
                        : null)),
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            HomePage(),
            CollectionsPage(),
            RecordPage(),
            AudioListPage(),
            ProfilePage(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MainPanel(
            currentIndex: currentIndex,
            onChange: (index) {
              setPage(index);
              currentIndex = index;
              setState(() {});
              print("index $index");
            },
            items: [
              ItemMainPanel(
                icon: IconSvg(IconsSvg.home,
                    width: 24, height: 24, color: colorActive),
                iconInactive: IconSvg(IconsSvg.home,
                    color: colorInactive, width: 24, height: 24),
                text: Text(
                  "Главная",
                  style: TextStyle(color: cBlue, fontSize: 10),
                ),
              ),
              ItemMainPanel(
                icon: IconSvg(IconsSvg.category,
                    width: 24, height: 24, color: colorActive),
                iconInactive: IconSvg(IconsSvg.category,
                    width: 24, height: 24, color: colorInactive),
                text: Text(
                  "Подборки",
                  style: TextStyle(color: cBlue, fontSize: 10),
                ),
              ),
              ItemMainPanel(
                colorActive: cOrange,
                colorInactive: cOrange,
                icon: Container(
                    decoration: BoxDecoration(
                      color: cOrange,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: IconSvg(IconsSvg.voice, width: 24, height: 24),
                    )),
                text: Text(
                  "Запись",
                  style: TextStyle(color: cBlue, fontSize: 10),
                ),
              ),
              ItemMainPanel(
                icon: IconSvg(IconsSvg.paper,
                    width: 24, height: 24, color: colorActive),
                iconInactive: IconSvg(IconsSvg.paper,
                    width: 24, height: 24, color: colorInactive),
                text: Text(
                  "Аудиозаписи",
                  style: TextStyle(color: cBlue, fontSize: 10),
                ),
              ),
              ItemMainPanel(
                icon: IconSvg(IconsSvg.profile,
                    width: 24, height: 24, color: colorActive),
                iconInactive: IconSvg(IconsSvg.profile,
                    width: 24, height: 24, color: colorInactive),
                text: Text(
                  "Профиль",
                  style: TextStyle(color: cBlue, fontSize: 10),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
