import 'package:flutter/material.dart';
import 'package:recorder/Models/CollectionModal.dart';
import 'package:recorder/UI/Home/HomePage/widgets/FirstCollectionItem.dart';
import 'package:recorder/UI/Home/HomePage/widgets/SmallCollectionItem.dart';
import 'package:recorder/generated/l10n.dart';

class Collections extends StatefulWidget {
  List<CollectionItem> items;
  Function(int index) onTapCollection;
  Function onAddCollection;
  Collections(
      {@required this.items, this.onAddCollection, this.onTapCollection});
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).collections,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.05)),
              GestureDetector(
                onTap: () {},
                child: Text(S.of(context).open_all,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
        colleectionsPreview()
      ],
    );
  }

  colleectionsPreview() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CollectionItemOne(
            length: 0,
            width: (MediaQuery.of(context).size.width / 2 - 63) * 240 / 183,
            height: ((MediaQuery.of(context).size.width / 2 - 63) * 240 / 183) *
                240 /
                183,
            img:
                'https://www.sunhome.ru/i/wallpapers/57/chert-kartinka.orig.jpg',
            title: 'Сказки  про Черт ',
            audioQuantity: '13',
            timeOfCollection: '1:30',
            onTap: () {
              if (widget.items.length < 1) {
                if (widget.onAddCollection != null) {
                  widget.onAddCollection();
                }
              } else if (widget.onTapCollection != null) {
                widget.onTapCollection(0);
              }
            },
          ),
          Container(
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCollectionItem(
                    text: widget.items.length == 0
                        ? S.of(context).here
                        : S.of(context).add,
                    length: 0,
                    width: (MediaQuery.of(context).size.width / 2 - 63) *
                        240 /
                        183,
                    height: ((MediaQuery.of(context).size.width / 2 - 63) *
                            240 /
                            183) *
                        113 /
                        183,
                    contColor: Color.fromRGBO(241, 180, 136, 0.8),
                    onTap: () {
                      if (widget.items.length < 2) {
                        if (widget.onAddCollection != null) {
                          widget.onAddCollection();
                        }
                      } else if (widget.onTapCollection != null) {
                        widget.onTapCollection(1);
                      }
                    }),
                SmallCollectionItem(
                    text: widget.items.length == 0
                        ? S.of(context).and_here
                        : S.of(context).add,
                    length: 0,
                    width: (MediaQuery.of(context).size.width / 2 - 63) *
                        240 /
                        183,
                    height: ((MediaQuery.of(context).size.width / 2 - 63) *
                            240 /
                            183) *
                        113 /
                        183,
                    contColor: Color.fromRGBO(103, 139, 210, 0.8),
                    onTap: () {
                      if (widget.items.length < 3) {
                        if (widget.onAddCollection != null) {
                          widget.onAddCollection();
                        }
                      } else if (widget.onTapCollection != null) {
                        widget.onTapCollection(2);
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
