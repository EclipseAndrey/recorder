import 'package:flutter/material.dart';
import 'package:recorder/Models/ProfileModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class ProfileImage extends StatefulWidget {
  bool isEdit;
  ProfileModel person;

  ProfileImage({@required this.isEdit, @required this.person});
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return widget.isEdit ? imageIsEdit(context) : imageNotEdit(context);
  }

  Widget imageNotEdit(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.55,
          height: MediaQuery.of(context).size.width * 0.55,
          child: Image(image: NetworkImage(widget.person.img))),
    );
  }

  Widget imageIsEdit(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.width * 0.55,
              child: Image(image: NetworkImage(widget.person.img))),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.width * 0.55,
            decoration: BoxDecoration(color: cBlack.withOpacity(0.5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0),
              child: IconSvg(IconsSvg.changePhoto,
                  width: 80 / (MediaQuery.of(context).size.width * 0.55)),
            ),
          )
        ]),
      ),
    );
  }
}
