import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'IconData.dart';

Widget IconSvg(int id,
    {Color color, double width, double height, bool nullColor}) {
  String icon(String name, {bool active, bool check}) {
    String path = "assets/images/";
    if (active != null) path = "lib/assets/icons/active/";
    if (check != null) path = "lib/assets/icons/checkBox/";
    String ex = ".svg";
    return path + name + ex;
  }

  String iconName;

  int count = 13;
  if (id < 0 || id >= count) id = 0;

  switch (id) {
    case 0:
      iconName = icon('back_ellipse');
      break;
    case 1:
      iconName = icon('heart');
      break;
    case 2:
      iconName = icon('voice');
      break;
    case 3:
      iconName = icon('profile');
      break;
    case 4:
      iconName = icon('paper');
      break;
    case 5:
      iconName = icon('home');
      break;
    case 6:
      iconName = icon('category');
      break;
    case 7:
      iconName = icon('menu');
      break;
    case 8:
      iconName = icon('more');
      break;
    case 9:
      iconName = icon('play');
      break;
    case 10:
      iconName = icon('audioArrow');
      break;
    case 11:
      iconName = icon('moreAudios');
      break;
    case 12:
      iconName = icon('changePhoto');
      break;
    default:
      iconName = icon('heart');
      break;
  }

  final String assetName = iconName;
  final Widget svg = SvgPicture.asset(assetName,
      height: height, width: width, color: color, semanticsLabel: 'Acme Logo');

  return svg;
}
