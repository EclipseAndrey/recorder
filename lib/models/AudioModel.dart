import 'package:flutter/cupertino.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class AudioItem {
  String name;
  Duration time;
  int activeIcon = IconsSvg.pause;
  int inActiveIcon = IconsSvg.play;
  String description;
  String url;
  String picture;
  int id;

  AudioItem({
    @required this.name,
     this.time ,
     this.activeIcon ,
     this.inActiveIcon ,
    @required this.description,
    @required this.url,
    @required this.picture,
    int id
  });

  factory AudioItem.fromMap(Map<String, dynamic> map) {
    return new AudioItem(
      name: map['name'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      picture: map['picture'] as String,
      id: map['id'] as int,
      time:  Duration(seconds: 60),
      activeIcon: IconsSvg.pause,
      inActiveIcon: IconsSvg.play
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'description': this.description,
      'url': this.url,
      'picture': this.picture,
      'id': this.id,
    } as Map<String, dynamic>;
  }
}
