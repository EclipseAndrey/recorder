import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Home/widgets/AudioPreviewWidget.dart';
import 'package:recorder/UI/Pages/Home/widgets/CollectionsWidget.dart';
import 'package:recorder/UI/widgets/Appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackground.withOpacity(0.0),
        appBar: MyAppBar(
          buttonMore: false,
          buttonBack: false,
          buttonMenu: true,
          padding: 11,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Collections(
                  items: [],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 44.0),
                  child: AudioPreview(
                    items: [
                      AudioItem(
                          name: 'Малыш Кокки 1', time: Duration(minutes: 3)),
                      AudioItem(
                          name: 'Малыш Кокки 1', time: Duration(minutes: 3)),
                      AudioItem(
                          name: 'Малыш Кокки 1', time: Duration(minutes: 3)),
                      AudioItem(
                          name: 'Малыш Кокки 1', time: Duration(minutes: 3))
                    ],
                  ),
                ),
                SizedBox(
                  height: 110,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
