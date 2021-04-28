import 'package:recorder/Controllers/States/RestoreState.dart';
import 'package:recorder/Rest/Audio/AudioProvide.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogIntegron.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogLoading.dart';
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
      if(_items[i].id == item.id){
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
        Put response = await AudioProvider.delete(out[i].id);
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
    showDialogLoading(AppKeys.scaffoldKey.currentContext);
    Put error;
    if(_items.length > 0){
      for(int i =0; i< _items.length; i++){
        Put response = await AudioProvider.delete(_items[i].idS);
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
    showDialogLoading(AppKeys.scaffoldKey.currentContext);
    Put response = await AudioProvider.delete(item.id);
    closeDialog(AppKeys.scaffoldKey.currentContext);
    if(response.error == 200){
      showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Перемещено в корзину");
    }else{
      showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Во время удаления были  непредвиденные ошибки, попробуйте еще раз, если ошибка повторяется - обратитесь в тех поддержку");
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