import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Models/CollectionModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Home/widgets/FirstCollectionItem.dart';
import 'package:recorder/UI/widgets/Appbar.dart';

import 'OpenCollection/OpenCollection.dart';

class CollectionsPage extends StatefulWidget {

  List<CollectionItem> items;

  CollectionsPage({this.items});
  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  List<CollectionItem> leftColumn = [];
  List<CollectionItem> rightColumn = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.items.length; i += 2) {
      try {
        leftColumn.add(widget.items[i]);
      } catch (e) {}

      try {
        rightColumn.add(widget.items[i + 1]);
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cBlack.withOpacity(0.0),
        appBar: MyAppBar(
          buttonMore: false,
          buttonMenu: false,
          buttonBack: false,
          padding: 18,
          top: 16,
          height: 90,
          child: Container(
            child: Column(
              children: [
                Text(
                  "Подборки",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontFamily: fontFamilyMedium,
                      letterSpacing: 2),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Все в одном месте",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: fontFamilyMedium,
                      letterSpacing: 2),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              SizedBox(
                height: 56,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                        leftColumn.length,
                        (index) => Column(
                              children: [
                                CollectionItemOne(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OpenColletion(
                                                item: leftColumn[index])));
                                  },
                                  length: 1,
                                  height: MediaQuery.of(context).size.height *
                                      240 /
                                      896,
                                  width: MediaQuery.of(context).size.width *
                                      183 /
                                      414,
                                  img: leftColumn[index].picture,
                                  timeOfCollection:
                                      leftColumn[index].timeOfCollection,
                                  title: leftColumn[index].name,
                                  audioQuantity:
                                      leftColumn[index].count,
                                ),
                                SizedBox(height: 16)
                              ],
                            )),
                  ),
                  SizedBox(width: 15.5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                        rightColumn.length,
                        (index) => Column(
                              children: [
                                CollectionItemOne(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OpenColletion(
                                                item: rightColumn[index])));
                                  },
                                  length: 1,
                                  height: MediaQuery.of(context).size.height *
                                      240 /
                                      896,
                                  width: MediaQuery.of(context).size.width *
                                      183 /
                                      414,
                                  img: rightColumn[index].picture,
                                  timeOfCollection:
                                      rightColumn[index].timeOfCollection,
                                  title: rightColumn[index].name,
                                  audioQuantity:
                                      rightColumn[index].count,
                                ),
                                SizedBox(height: 16)
                              ],
                            )),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
