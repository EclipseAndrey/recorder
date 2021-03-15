import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'IconData.dart';

Widget IconSvg( {@required int id, Color color, double width, double height, bool nullColor}){

  String icon (String name, {bool active, bool check}){
    String path = "assets/images/";
    if(active != null)path="lib/assets/icons/active/";
    if(check != null)path="lib/assets/icons/checkBox/";
    String ex = ".svg";
    return path+name+ex;
  }

  String iconName;

  int count = 2;
  if(id < 0||id >= count)id=0;

  switch(id) {
    case 0: iconName =icon('back_ellipse'); break;
    case 1: iconName =icon('heart'); break;
  }



  final String assetName = iconName;
  final  Widget svg =

  SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      color: color,
      semanticsLabel: 'Acme Logo'
  );

  return svg;

}