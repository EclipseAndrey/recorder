import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:recorder/Controllers/GeneralController.dart';
import 'package:recorder/Controllers/States/CollectionsSate.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import 'package:provider/provider.dart';
import 'package:recorder/UI/widgets/AudioItem.dart';
import 'package:recorder/Utils/DropMenu/DropMenuItem.dart';
import 'package:recorder/Utils/DropMenu/FocusedMunu.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';
import 'package:recorder/Utils/time/TimeParse.dart';
import 'package:recorder/models/AudioModel.dart';
class StateViewItemCollection extends StatefulWidget {
  @override
  _StateViewItemCollectionState createState() => _StateViewItemCollectionState();
}

class _StateViewItemCollectionState extends State<StateViewItemCollection> {

  bool openDesc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlack.withOpacity(0.0),
      appBar: MyAppBar(
        buttonMore: false,
        buttonMenu: true,
        buttonBack: true,
        buttonAdd: false,
        buttonDone: false,
        padding: 18,
        top: 16,
        textRightButton: "Добавить",
        height: 90,
        tapLeftButton: (){
          context.read<GeneralController>().collectionsController.back();
        },
        tapRightButton:  (){
          //todo open menu
        },
        childRight: FocusedMenuHolder(
            blurSize: 0,
            blurBackgroundColor: Colors.transparent,
            duration: Duration(milliseconds: 50),
            menuBoxDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            menuWidth: MediaQuery.of(context).size.width/2,
            menuOffset: 10,
            menuItems:[
              FocusedMenuItem(onPressed: (){
                context.read<GeneralController>().collectionsController.edit();
              }, title: Text("Редактировать",style: TextStyle(color: cBlack, fontWeight: FontWeight.w400, fontSize: 14, fontFamily: fontFamily),),),
              FocusedMenuItem(onPressed: (){}, title: Text("Выбрать несколько",style: TextStyle(color: cBlack, fontWeight: FontWeight.w400, fontSize: 14, fontFamily: fontFamily),),),
              FocusedMenuItem(onPressed: (){}, title: Text("Удалить подборку",style: TextStyle(color: cBlack, fontWeight: FontWeight.w400, fontSize: 14, fontFamily: fontFamily),),),
              FocusedMenuItem(onPressed: (){}, title: Text("Поделиться",style: TextStyle(color: cBlack, fontWeight: FontWeight.w400, fontSize: 14, fontFamily: fontFamily),),),
            ],
            onPressed: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 11),
              child: Container(
                width: 27,
                height: 27,
                child: Center(
                  child: IconSvg(IconsSvg.more,
                      width: 41, height: 8, color: cBackground),
                ),
              ),
            )),

      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width - 40,
                      child: _header()),
                ],
              ),
            ),
            SizedBox(height: 20,),
            _image(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 28,right: 30),
              child: _desc(),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 17),
              child: _listAudio(),
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }

  Widget _header(){
    return StreamBuilder<CollectionsState>(
      stream: context.read<GeneralController>().collectionsController.streamCollections,
      builder: (context, snapshot) {
        return Text(snapshot.data.currentItem.name??"Подборка", style: TextStyle(color: cBackground, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: fontFamily),);
      }
    );
  }
  Widget _image(){
    return StreamBuilder<CollectionsState>(
        stream: context.read<GeneralController>().collectionsController.streamCollections,
        builder: (context, snapshot) {
          return GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: (){

            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                width: MediaQuery.of(context).size.width-32,
                height: (MediaQuery.of(context).size.width-32)*240/382,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0,4),
                          blurRadius: 20,
                          spreadRadius: 0
                      )
                    ],
                    color: cBackground.withOpacity(0.9)
                ),
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width-32,
                        height: (MediaQuery.of(context).size.width-32)*240/382,
                        child: Image.network(snapshot.data.currentItem.picture, fit: BoxFit.cover,)),
                    Container(
                        width: MediaQuery.of(context).size.width-32,
                        height: (MediaQuery.of(context).size.width-32)*240/382,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0),
                                  Color.fromRGBO(0, 0, 0, 0),
                                  Color.fromRGBO(69, 69, 69, 1)
                                ]))
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Text(snapshot.data.currentItem.publicationDate??"date", style: TextStyle(color: cBackground, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w700),),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 30),
                        child: Text("${snapshot.data.currentItem.count} аудио\n${time(snapshot.data.currentItem.duration)}", style: TextStyle(color: cBackground, fontWeight: FontWeight.w400, fontSize: 14, fontFamily: fontFamily),),
                      ),
                    ),
                    snapshot.data.currentItem.playlist == null ||snapshot.data.currentItem.playlist.length == 0?SizedBox():Align(


                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                        child: Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              behavior: HitTestBehavior.deferToChild,
                              onTap: (){
                                context.read<GeneralController>().playerController.play(snapshot.data.currentItem.playlist);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(245, 245, 245, 0.16),
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconSvg(IconsSvg.play, color: cBackground, height: 38, width: 38),
                                      SizedBox(width: 10,),
                                      Text("Запустить все", style: TextStyle(color: cBackground , fontFamily: fontFamily, fontSize: 14 , fontWeight: FontWeight.w400,),),
                                      SizedBox(width: 15,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            ),
          );
        }
    );
  }
  Widget _desc(){
    return Container(
      child: StreamBuilder<CollectionsState>(
        stream: context.read<GeneralController>().collectionsController.streamCollections,
        builder: (context, snapshot) {
            return !openDesc?GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: (){
                openDesc = true;
                setState(() {});
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 40,
                  maxHeight: 100,
                  minWidth:  MediaQuery.of(context).size.width,
                  maxWidth:  MediaQuery.of(context).size.width
                ),
                child: Text(snapshot.data.currentItem.description ?? "",
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: cBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: fontFamily),),
              ),
            ):GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: (){
                openDesc = false;
                setState(() {});
              },
              child: ConstrainedBox(

                constraints: BoxConstraints(
                    minHeight: 40,
                    maxHeight: double.maxFinite,
                    minWidth:  MediaQuery.of(context).size.width,
                    maxWidth:  MediaQuery.of(context).size.width
                ),
                child: Text(snapshot.data.currentItem.description ?? "",
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: cBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: fontFamily),),
              ),
            );

        }
      )
    );
  }
  Widget _listAudio(){
    return StreamBuilder<CollectionsState>(
      stream: context.read<GeneralController>().collectionsController.streamCollections,
      builder: (context, snapshot) {
        List<AudioItem> list = snapshot.data.currentItem.playlist;
        return list == null || list.length == 0?Container(width: MediaQuery.of(context).size.width, child: Center(child: Text("Нет аудиозаписей", style: TextStyle(color: cBlack.withOpacity(0.4), fontFamily: fontFamily,fontSize: 24, fontWeight: FontWeight.w700),),),):Container(
          child: Column(
            children: List.generate(list.length, (index) {
          return Column(
            children: [
              AudioItemWidget(
                colorPlay: cSwamp,
                selected: false,
                onSelect: (){
                  //todo select
                },
                item: list[index],
              ),
              SizedBox(height: 10,),
            ],
          );
        },
          ),
        ));
      }
    );

  }
}
