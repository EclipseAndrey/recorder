import 'package:flutter/material.dart';
import 'package:recorder/Controllers/GeneralController.dart';
import 'package:recorder/Controllers/States/CollectionsSate.dart';
import 'package:provider/provider.dart';
import 'package:recorder/UI/Pages/Collections/StateAddAudioCollection.dart';
import 'package:recorder/UI/Pages/Collections/StateAddCollection.dart';
import 'package:recorder/UI/Pages/Collections/StateEditCollection.dart';
import 'package:recorder/UI/Pages/Collections/StateLoadingColletion.dart';
import 'package:recorder/UI/Pages/Collections/StateViewCollection.dart';
import 'package:recorder/UI/Pages/Collections/StateViewItemCollection.dart';

class CollectionsPage extends StatefulWidget {


  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<CollectionsState>(
        stream: context.read<GeneralController>().collectionsController.streamCollections,
        builder: (context, snapshot) {
          print("CollectionsPage data "+snapshot.data.toString());
          if(!snapshot.hasData){
            return StateLoadingCollection();
          }
          else if(snapshot.data.stateSelect == CollectionsSelection.loading){
            return StateLoadingCollection();
          }else if(snapshot.data.stateSelect == CollectionsSelection.view){
            return StateViewCollection(items: snapshot.data.items,);
          }else if(snapshot.data.stateSelect == CollectionsSelection.viewItem){
            return StateViewItemCollection();
          }else if(snapshot.data.stateSelect == CollectionsSelection.editing){
            return StateEditCollection();
          }else if(snapshot.data.stateSelect == CollectionsSelection.addAudio){
            return StateAddAudioCollection();
          }else if(snapshot.data.stateSelect == CollectionsSelection.add){
            return StateAddCollection();
          }else{
            return StateLoadingCollection();
          }
        },),
    );
  }
}
