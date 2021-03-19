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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 66),
      child: Scaffold(
        backgroundColor: cBackground.withOpacity(0.0),
        appBar: MyAppBar(moreIsActive: false),
        body: SingleChildScrollView(
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
                        name: 'Малыш Кокки 1',
                        time: Duration(minutes: 1, seconds: 8000)),
                    AudioItem(
                        name: 'Малыш Кокки 1',
                        time: Duration(minutes: 1, seconds: 8000)),
                    AudioItem(
                        name: 'Малыш Кокки 1',
                        time: Duration(minutes: 1, seconds: 8000)),
                    AudioItem(
                        name: 'Малыш Кокки 1',
                        time: Duration(minutes: 1, seconds: 8000))
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
