import 'package:flutter/material.dart';

class CollectionsWidget extends StatefulWidget {
  @override
  _CollectionsWidgetState createState() => _CollectionsWidgetState();
}

class _CollectionsWidgetState extends State<CollectionsWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 320/240, child: Container(width: MediaQuery.of(context).size.width,),);
  }
}
/// 400-16*2 -50 -23 - 50  TextOverflow.