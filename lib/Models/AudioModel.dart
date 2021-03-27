import 'package:flutter/cupertino.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class AudioItem {
  String name;
  Duration time;
  int activeIcon = IconsSvg.pause;
  int disactiveIcon = IconsSvg.play;

  AudioItem({@required this.name, @required this.time});
}
