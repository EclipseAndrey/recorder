import 'package:flutter/material.dart';
import 'package:recorder/Controllers/States/RestoreState.dart';
import 'package:recorder/DB/DB.dart';
import 'package:recorder/Rest/Audio/AudioProvide.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogIntegron.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogLoading.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogRecorder.dart';
import 'package:recorder/Utils/app_keys.dart';
import 'package:recorder/models/AudioModel.dart';
import 'package:recorder/models/Put.dart';
import 'package:rxdart/rxdart.dart';

class RestoreController{

  BehaviorSubject _controllerRestore = BehaviorSubject<RestoreState>();
  get streamRestore => _controllerRestore.stream;

  List<AudioItem> _items;
  bool _loading = false;
  bool _select = false;

  RestoreController(){
    _loading = true;
  setState();
   load();
  }



  load()async{
    _loading = true;
    setState();
    _items =  await AudioProvider.deleted();
    _loading= false;
    setState();
  }


  tapSelect(AudioItem item){
    for(int i = 0; i < _items.length; i++){
      if(item.id == null?item.idS == _items[i].idS:item.id == _items[i].id){
        if(_items[i].select == null || !_items[i].select){
          _items[i].select = true;
        }else{
          _items[i].select = false;
        }
      }
    }
    setState();
  }

  deleteSelect()async{
    Put error;
    showDialogLoading(AppKeys.scaffoldKey.currentContext);
    List<AudioItem> out = [];
    for(int i =0; i< _items.length; i++){
      if(_items[i].select != null && _items[i].select)out.add(_items[i]);
    }

    if(out.length > 0){
      for(int i =0; i< out.length; i++){
        Put response = await AudioProvider.delete(null, ids:out[i].idS);
        if(response.error == 200){
          ///ok
        }else{
          error = response;
        }
      }
    }
    _select = false;
    await load();


    closeDialog(AppKeys.scaffoldKey.currentContext);
    if(error != null){
      showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Во время удаления были  непредвиденные ошибки, попробуйте еще раз, если ошибка повторяется - обратитесь в тех поддержку");
    }
  }

  restoreSelect()async{
    Put error;
    showDialogLoading(AppKeys.scaffoldKey.currentContext);
    List<AudioItem> out = [];
    for(int i =0; i< _items.length; i++){
      if(_items[i].select != null && _items[i].select)out.add(_items[i]);
    }

    if(out.length > 0){
      for(int i =0; i< out.length; i++){
        Put response = await AudioProvider.restore(out[i].idS);
        if(response.error == 200){
          ///ok
        }else{
          error = response;
        }
      }
    }
    _select = false;
    await load();


    closeDialog(AppKeys.scaffoldKey.currentContext);
    if(error != null){
      showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Во время удаления были  непредвиденные ошибки, попробуйте еще раз, если ошибка повторяется - обратитесь в тех поддержку");
    }
  }
  restoreAll()async{
    showDialogLoading(AppKeys.scaffoldKey.currentContext);
    Put error;
    if(_items.length > 0){
      for(int i =0; i< _items.length; i++){
        Put response = await AudioProvider.restore(_items[i].idS);
        if(response.error == 200){
          ///ok
        }else{
          error = response;
        }
      }
    }
    _select = false;
    await load();
    closeDialog(AppKeys.scaffoldKey.currentContext);

    if(error != null){
      showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Во время удаления были  непредвиденные ошибки, попробуйте еще раз, если ошибка повторяется - обратитесь в тех поддержку");
    }
  }

  deleteAll()async{
    print("a");
    showDialogLoading(AppKeys.scaffoldKey.currentContext);
    Put error;
    if(_items.length > 0){
      for(int i =0; i< _items.length; i++){
        Put response = await AudioProvider.delete(null, ids:_items[i].idS);
        if(response.error == 200){
          ///ok
        }else{
          error = response;
        }
      }
    }
    _select = false;
    await load();
    closeDialog(AppKeys.scaffoldKey.currentContext);

    if(error != null){
      showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Во время удаления были  непредвиденные ошибки, попробуйте еще раз, если ошибка повторяется - обратитесь в тех поддержку");
    }
  }

  delete(AudioItem item)async{
    if(item.idS == null ){
      showDialogRecorder(
          context: AppKeys.scaffoldKey.currentContext,
          title: Text(
            "Точно удалить?",
            style: TextStyle(
                color: cBlack,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: fontFamily),
          ),
          body: Text("Запись будет безвозвратно удалена ", textAlign: TextAlign.center, style: TextStyle(color: cBlack.withOpacity(0.7), fontFamily: fontFamily, fontSize: 14),),
          buttons: [
            DialogIntegronButton(onPressed: ()async{
              await DBProvider.db.audioDelete(item.id);
              closeDialog(AppKeys.scaffoldKey.currentContext);
            }, textButton: Text("Удалить", style: TextStyle(color: cBackground, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w500),), background: cRed, borderColor: cRed),
            DialogIntegronButton(onPressed: (){
              closeDialog(AppKeys.scaffoldKey.currentContext);
            }, textButton: Text("Нет", style: TextStyle(color: cBlueSoso, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w400),), borderColor: cBlueSoso),
          ]
      );
    }else{
      showDialogLoading(AppKeys.scaffoldKey.currentContext);
      Put response = await AudioProvider.delete(item.id, ids:item.idS);
      if(item.id != null){
        await DBProvider.db.audioDelete(item.id);
      }
      closeDialog(AppKeys.scaffoldKey.currentContext);
      if(response.error == 200){
        showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Удалено");
      }else{
        showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Во время удаления были  непредвиденные ошибки, попробуйте еще раз, если ошибка повторяется - обратитесь в тех поддержку");
      }
      load();

    }



  }


  setSelect(bool status){
    if(status)for(int i = 0; i< _items.length; i++){
      _items[i].select = false;
      if(_items.isNotEmpty){_select = status;}
    }else{
      _select = status;
    }

    setState();
  }


  setState(){
    RestoreState state = RestoreState(items: _items, loading: _loading, select: _select);
    _controllerRestore.sink.add(state);
  }

  dispose(){
    _controllerRestore.close();
  }
}