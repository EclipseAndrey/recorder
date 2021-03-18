import 'package:flutter/material.dart';
import 'package:recorder/Models/CollectionModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Home/widgets/FirstCollectionItem.dart';
import 'package:recorder/UI/widgets/Appbar.dart';

class CollectionsPage extends StatefulWidget {
  List<CollectionItem> items = [
    CollectionItem(
        image: 'https://i.imgur.com/RlGN70F.jpg',
        title: 'Золотая рыбка',
        audioQuantity: '7',
        timeOfCollection: '30'),
    CollectionItem(
        image: 'https://i.imgur.com/RlGN70F.jpg',
        title: 'Золотая рыбка',
        audioQuantity: '7',
        timeOfCollection: '30'),
    CollectionItem(
        image: 'https://i.imgur.com/RlGN70F.jpg',
        title: 'Золотая рыбка',
        audioQuantity: '7',
        timeOfCollection: '30'),
    CollectionItem(
        image: 'https://i.imgur.com/RlGN70F.jpg',
        title: 'Золотая рыбка',
        audioQuantity: '7',
        timeOfCollection: '30')
  ];
  // CollectionsPage({this.length});
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
    return Padding(
      padding: const EdgeInsets.only(top: 56.0, left: 16.0, right: 16.0),
      child: Scaffold(
        backgroundColor: cBlack.withOpacity(0.0),
        appBar: MyAppBar(
          moreIsActive: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                                onTap: () {},
                                length: 1,
                                height: MediaQuery.of(context).size.height *
                                    240 /
                                    896,
                                width: MediaQuery.of(context).size.width *
                                    183 /
                                    414,
                                img: leftColumn[index].image,
                                timeOfCollection:
                                    leftColumn[index].timeOfCollection,
                                title: leftColumn[index].title,
                                audioQuantity: leftColumn[index].audioQuantity,
                              ),
                              SizedBox(height: 16)
                            ],
                          )),
                ),
                SizedBox(width: 15.5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                      leftColumn.length,
                      (index) => Column(
                            children: [
                              CollectionItemOne(
                                onTap: () {},
                                length: 1,
                                height: MediaQuery.of(context).size.height *
                                    240 /
                                    896,
                                width: MediaQuery.of(context).size.width *
                                    183 /
                                    414,
                                img: rightColumn[index].image,
                                timeOfCollection:
                                    rightColumn[index].timeOfCollection,
                                title: rightColumn[index].title,
                                audioQuantity: rightColumn[index].audioQuantity,
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
    );
  }
}
