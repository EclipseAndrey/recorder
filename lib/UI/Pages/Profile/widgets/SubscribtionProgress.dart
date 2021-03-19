import 'package:flutter/material.dart';
import 'package:recorder/Models/ProfileModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Profile/widgets/ProgressBar.dart';
import 'package:recorder/generated/l10n.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SubcriptionProgress extends StatefulWidget {
  ProfileModel person;
  SubcriptionProgress({@required this.person});
  @override
  _SubcriptionProgressState createState() => _SubcriptionProgressState();
}

class _SubcriptionProgressState extends State<SubcriptionProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          height: 20,
        ),
        MyProgressBar(
          usage: widget.person.usMemory,
          available: widget.person.avMemory,
          width: MediaQuery.of(context).size.width * 0.74,
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        SizedBox(
          height: 8,
        ),
        Text('${widget.person.usMemory}/${widget.person.avMemory} мб',
            style: subscriptionTextStyle)
      ],
    );
  }
}
