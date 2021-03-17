import 'package:flutter/cupertino.dart';

class CollectionItem {
  String image;
  String name;
  String audioQuantity;
  String timeOfCollection;

  CollectionItem(
      {@required this.image,
      @required this.name,
      @required this.audioQuantity,
      @required this.timeOfCollection});
}

class Collection extends CollectionItem {
  List<CollectionItem> collectionItemsList;

  Collection({@required this.collectionItemsList});
}
