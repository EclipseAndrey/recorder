import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Models/CollectionModel.dart';
import 'package:recorder/Rest/Audio/AudioProvide.dart';
import 'package:recorder/Rest/Playlist/PlaylistProvider.dart';

class HomeState{
  List<CollectionItem> collections;
  List<AudioItem> audios;
  bool loading;
  bool errors;

  HomeState({
    @required this.collections,
    @required this.audios,
    @required this.loading,
    @required this.errors,
  });


}


class HomeController{

  List<CollectionItem> collections;
  List<AudioItem> audios;

  final _streamController = StreamController<HomeState>.broadcast();

  get stream => _streamController.stream;
  HomeController(){load();}

  load()async{
    collections = await PlaylistProvider.get();
    audios = await AudioProvider.get();
    _streamController.sink.add(HomeState(collections: collections,audios: audios,errors: false,loading: false));
  }


  dispose(){
    _streamController.close();
  }

}