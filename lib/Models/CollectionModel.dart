import 'package:flutter/cupertino.dart';

class CollectionItem {
  final String image;
  final String title;
  final String audioQuantity;
  final String timeOfCollection;

  CollectionItem(
      {@required this.image,
      @required this.title,
      @required this.audioQuantity,
      @required this.timeOfCollection});
}
