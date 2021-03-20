import 'package:flutter/cupertino.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/UI/widgets/AudioItem.dart';

class CollectionItem {
  final String image;
  final String title;
  final String description;
  final List<AudioItem> playlist;
  final String publicationDate;
  final String audioQuantity;
  final String timeOfCollection;

  CollectionItem(
      {@required this.image,
      @required this.title,
      this.description,
      this.playlist,
      this.publicationDate,
      @required this.audioQuantity,
      @required this.timeOfCollection});
}
