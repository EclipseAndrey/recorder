import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Models/CollectionModel.dart';
import 'package:recorder/UI/Pages/AudioList/AudioListPage.dart';
import 'package:recorder/UI/Pages/Collections/OpenCollection/widgets/CollectionPhotoWidget.dart';
import 'package:recorder/UI/Pages/Collections/OpenCollection/widgets/DesriptionWidget.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import 'package:recorder/UI/widgets/AudioPreviewGenerate.dart';
import 'package:recorder/UI/widgets/Background.dart';
import '../../../../Style.dart';

class OpenColletion extends StatefulWidget {
  final CollectionItem item;
  OpenColletion({this.item});

  @override
  _OpenColletionState createState() => _OpenColletionState();
}

class _OpenColletionState extends State<OpenColletion> {
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
          alignment: Alignment.topCenter,
          child: Background(
            color: cSwamp,
          )),
      SafeArea(
          child: Scaffold(
        backgroundColor: cBackground.withOpacity(0.0),
        appBar: MyAppBar(
          buttonMore: true,
          buttonBack: true,
          buttonMenu: true,
          top: 25,
          height: 100,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.item.name,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: fontFamily,
                        letterSpacing: 1.05),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CollectionPhotoWidget(item: widget.item),
              SizedBox(height: 20),
              DescriptionWidget(description: widget.item.description),
              SizedBox(height: 14),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 12),
                    child: AudioPreviewGenerate(
                        items: widget.item.playlist,
                        colorPlay: cSwamp,
                        currentIndex: currentIndex,
                        onChange: (index) {
                          currentIndex = index;
                          setState(() {});
                          print('index $index');
                        }),
                  ),
                ],
              ),
              SizedBox(height: 110)
            ],
          ),
        ),
      )),
    ]);
  }
}
