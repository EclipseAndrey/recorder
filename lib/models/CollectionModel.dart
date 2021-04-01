import 'package:flutter/cupertino.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/UI/widgets/AudioItem.dart';

class CollectionItem {
  final int id;
  final String picture;
  final String name;
  final String description;
  final List<AudioItem> playlist;
  final String publicationDate;
  final String count;
  final String timeOfCollection;

  CollectionItem(
      this.id,
      {@required this.picture,
      @required this.name,
      this.description,
      this.playlist,
      this.publicationDate,
      @required this.count,
      @required this.timeOfCollection
      });

  factory CollectionItem.fromMap(Map<String, dynamic> map) {
    return new CollectionItem(
      map['id'] as int,
      picture: map['picture'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      playlist: map['playlist'] as List<AudioItem>,
      publicationDate: map['publicationDate'] as String,
      count: map['count'] as String,
      timeOfCollection: map['timeOfCollection'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'picture': this.picture,
      'name': this.name,
      'description': this.description,
      'playlist': this.playlist,
      'publicationDate': this.publicationDate,
      'count': this.count,
      'timeOfCollection': this.timeOfCollection,
    } as Map<String, dynamic>;
  }
}
