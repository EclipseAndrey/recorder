import 'package:flutter/material.dart';
import 'package:recorder/Models/ProfileModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Profile/widgets/Image.dart';
import 'package:recorder/UI/Pages/Profile/widgets/Name.dart';
import 'package:recorder/UI/Pages/Profile/widgets/PhoneNumber.dart';
import 'package:recorder/UI/Pages/Profile/widgets/SubscribtionProgress.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import 'package:recorder/generated/l10n.dart';
import 'package:recorder/main.dart';

class ProfilePage extends StatefulWidget {
  bool isEdit = false;
  ProfileModel person = ProfileModel(
      img:
          'https://i0.wp.com/ru.maestro24.org/wp-content/uploads/2019/08/5ec8fa394089b2517a1194120352615e.jpg?fit=1080%2C1080&ssl=1',
      name: 'Коля',
      phoneNumber: '+7 (676) 465 12 12',
      usMemory: 150,
      avMemory: 500);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 66),
      child: Scaffold(
        backgroundColor: cBackground.withOpacity(0.0),
        appBar: MyAppBar(moreIsActive: false),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: widget.isEdit ? profileIsEdit() : profileNotEdit(context),
          ),
        ),
      ),
    );
  }

  Widget profileIsEdit() {
    return Column(
      children: [
        ProfileImage(isEdit: widget.isEdit, person: widget.person),
        SizedBox(
          height: 40,
        ),
        ProfileName(isEdit: widget.isEdit, person: widget.person),
        SizedBox(
          height: 80,
        ),
        PhoneNumber(isEdit: widget.isEdit, person: widget.person),
        SizedBox(
          height: 40,
        ),
        changeButton()
      ],
    );
  }

  Widget profileNotEdit(BuildContext context) {
    return Column(
      children: [
        ProfileImage(isEdit: widget.isEdit, person: widget.person),
        SizedBox(
          height: 14,
        ),
        ProfileName(isEdit: widget.isEdit, person: widget.person),
        PhoneNumber(isEdit: widget.isEdit, person: widget.person),
        changeButton(),
        SizedBox(
          height: 45,
        ),
        SubcriptionProgress(person: widget.person),
        SizedBox(
          height: 65,
        ),
        bottomRow(context),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }

  Widget changeButton() {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.isEdit = !widget.isEdit;
          });
        },
        child: widget.isEdit
            ? Text(S.of(context).save, style: phoneTextStyle(isPhone: false))
            : Text(
                S.of(context).edit_number,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, color: cBlack),
              ));
  }

  Container bottomRow(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.745,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.deferToChild,
            child: Text(
              S.of(context).log_out,
              style: bottomProfileTextStyle(isLogOut: true),
            ),
          ),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.deferToChild,
            child: Text(
              S.of(context).delete_profile,
              style: bottomProfileTextStyle(isLogOut: false),
            ),
          ),
        ],
      ),
    );
  }
}
