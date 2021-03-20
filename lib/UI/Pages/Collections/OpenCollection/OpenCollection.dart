import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Models/CollectionModel.dart';
import 'package:recorder/UI/Pages/AudioList/AudioListPage.dart';
import 'package:recorder/UI/Pages/Collections/OpenCollection/widgets/CollectionPhotoWidget.dart';
import 'package:recorder/UI/Pages/Collections/OpenCollection/widgets/DesriptionWidget.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import '../../../../Style.dart';

class OpenColletion extends StatefulWidget {
  final CollectionItem item = CollectionItem(
      title: 'Сказка о малыше Кокки',
      description:
          'Сказка о маленьком принце. Он родился в старой деревне и задавался всего-лишь одним вопросом - “Кто я такой?”.\nОн познакомился со старенькой бабушкой, которая рассказала ему легенду о малыше Кокки...',
      publicationDate: '24.09.20',
      playlist: [
        AudioItem(
            name: 'Малыш Кокки 1', time: Duration(minutes: 1, seconds: 1740)),
        AudioItem(
            name: 'Малыш Кокки 2', time: Duration(minutes: 1, seconds: 1740)),
        AudioItem(
            name: 'Малыш Кокки 3', time: Duration(minutes: 1, seconds: 1740)),
        AudioItem(
            name: 'Малыш Кокки 4', time: Duration(minutes: 1, seconds: 1740)),
        AudioItem(
            name: 'Малыш Кокки 5', time: Duration(minutes: 1, seconds: 1740)),
      ],
      image: 'https://i.imgur.com/RlGN70F.jpg',
      audioQuantity: '7',
      timeOfCollection: '30');

  @override
  _OpenColletionState createState() => _OpenColletionState();
}

class _OpenColletionState extends State<OpenColletion> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  widget.item.title,
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
                playlistPreview(widget.item.playlist, colorPlay: cSwamp)
              ],
            ),
            SizedBox(height: 110)
          ],
        ),
      ),
    ));
  }
}
