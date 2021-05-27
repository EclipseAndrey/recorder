import 'package:flutter/material.dart';
import 'package:recorder/Controllers/GeneralController.dart';
import 'package:recorder/Rest/Playlist/PlaylistProvider.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Home/widgets/FirstCollectionItem.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogIntegron.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogLoading.dart';
import 'package:recorder/Utils/app_keys.dart';
import 'package:recorder/Utils/time/TimeParse.dart';
import 'package:recorder/models/AudioModel.dart';
import 'package:recorder/models/CollectionModel.dart';
import 'package:recorder/models/Put.dart';

addToPlaylist (AudioItem item, GeneralController controller){
  showModalBottomSheet(
      isScrollControlled: true,

      backgroundColor: Colors.transparent,
      context: AppKeys.scaffoldKey.currentContext,
      builder: (context){
        return AddAudioContent(controller: controller, item: item,);
      });
}

class AddAudioContent extends StatefulWidget {

  final GeneralController controller;
  final AudioItem item;
  const AddAudioContent({Key key, this.controller , this.item}) : super(key: key);

  @override
  _AddAudioContentState createState() => _AddAudioContentState();
}

class _AddAudioContentState extends State<AddAudioContent> {

  List<CollectionItem> leftColumn = [];
  List<CollectionItem> rightColumn = [];
  @override
  void initState() {
    // TODO: implement initState
    List<CollectionItem> items = widget.controller.collectionsController.itemsCollection;
    super.initState();
    for (int i = 0; i < items.length; i += 2) {
      try {
        leftColumn.add(items[i]);
      } catch (e) {}

      try {
        rightColumn.add(items[i + 1]);
      } catch (e) {}
    }
  }

  add(CollectionItem collectionItem)async{
    showDialogLoading(context);
    Put response = await PlaylistProvider.addAudioToPlaylist(collectionItem.id??collectionItem.idS, widget.item.id??widget.item.idS, isLocalAudio: widget.item.id==null?false:true, isLocalPlaylist: collectionItem.id == null?false:true);
    closeDialog(context);
    closeDialog(context);
    if( response.error == 201){
      showDialogIntegronError(context, "Добавлено");
      widget.controller.homeController.load();
    }else{
      showDialogIntegronError(context, "Не удалось добавть");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.70,
        width: MediaQuery.of(context).size.width * 0.98,
        decoration: BoxDecoration(
            color: cBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: _content()),
      ),
    );
  }
   Widget _content(){
    return Column(
      children: [

        SizedBox(height: 30,),
        Text("Выберите подборку", style: TextStyle(color: cBlack ,fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.w400, ),),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 15.5),
          child: Row(
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
                          onTap: () {
                            add(leftColumn[index]);
                          }, item: leftColumn[index],

                        ),
                        SizedBox(height: 16)
                      ],
                    )),
              ),
              SizedBox(width: 15.5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                    rightColumn.length,
                        (index) => Column(
                      children: [
                        CollectionItemOne(
                          onTap: () {
                            //todo
                            add(rightColumn[index]);

                          }, item: rightColumn[index],

                        ),
                        SizedBox(height: 16)
                      ],
                    )),
              )
            ],
          ),
        ),
      ],
    );
   }
}
