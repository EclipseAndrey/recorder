import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recorder/Controllers/States/CollectionsSate.dart';
import 'package:recorder/Rest/Playlist/PlaylistProvider.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogIntegron.dart';
import 'package:recorder/Utils/DialogsIntegron/DialogLoading.dart';
import 'package:recorder/Utils/app_keys.dart';
import 'package:recorder/models/AudioModel.dart';
import 'package:recorder/models/CollectionModel.dart';
import 'package:recorder/models/Put.dart';
import 'package:rxdart/rxdart.dart';

class CollectionsController {
  CollectionsSelection _stateSelect;
  List<CollectionItem> itemsCollection;
  CollectionItem _currentItem;
  List<AudioItem> _audios;
  List<AudioItem> _audiosAll;
  List<AudioItem> _audiosSearch;
  Function update;
  bool _edit;

  final _picker = ImagePicker();
  TextEditingController controllerHeader = TextEditingController();
  TextEditingController controllerComment = TextEditingController();
  TextEditingController controllerSearch = TextEditingController();
  String _pathPhoto;

  BehaviorSubject _behaviorSubject = BehaviorSubject<CollectionsState>();
  BehaviorSubject _behaviorSubjectPhoto = BehaviorSubject<String>();

  get streamCollections => _behaviorSubject.stream;

  get streamPhoto => _behaviorSubjectPhoto.stream;

  CollectionsController(this.update) {
    _audiosSearch = [];
    _stateSelect = CollectionsSelection.loading;
    setState();
    controllerSearch.addListener(() {
      _search();
    });
  }

  updateData() {
    update();
  }

  _search() {
    _audiosSearch = [];
    for (int i = 0; i < _audiosAll.length; i++) {
      RegExp exp = new RegExp(controllerSearch.text.toLowerCase());
      String str = _audiosAll[i].name.toLowerCase();
      String str2 = _audiosAll[i].description.toLowerCase();
      if (exp.hasMatch(str) || exp.hasMatch(str2)) {
        _audiosSearch.add(_audiosAll[i]);
      }
    }
    setState();
  }

  selectAudio(int id) {
    for (int i = 0; i < _audiosAll.length; i++) {
      if (_audiosAll[i].id == id) {
        if (_audiosAll[i].select != null && _audiosAll[i].select) {
          _audiosAll[i].select = false;
        } else {
          _audiosAll[i].select = true;
        }
      }
    }
    _search();
    setState();
  }

  setCollections(List<CollectionItem> items) {
    itemsCollection = items;
    _stateSelect = CollectionsSelection.view;
    setState();
  }

  setAudios(List<AudioItem> audios) {
    _audiosAll = audios;
  }

  addCollection() async {
    _audios = [];
    _stateSelect = CollectionsSelection.add;
    setState();
  }

  addAudio() {
    _stateSelect = CollectionsSelection.addAudio;
    setState();
  }

  edit({CollectionItem item}) {
    if (item != null) _currentItem = item;
    controllerHeader.text = _currentItem.name;
    controllerComment.text = _currentItem.description;
    _stateSelect = CollectionsSelection.editing;
    setState();
  }

  view(CollectionItem item) async {
    _stateSelect = CollectionsSelection.loading;
    setState();
    _currentItem = item;
    if (_currentItem.playlist == null)
      _currentItem.playlist = await PlaylistProvider.get(id: item.id);
    _stateSelect = CollectionsSelection.viewItem;
    setState();
  }

  back() {
    if (_stateSelect == CollectionsSelection.addAudio) {
      _audios = [];
      for (int i = 0; i < _audiosAll.length; i++) {
        if (_audiosAll[i].select != null && _audiosAll[i].select) {
          _audios.add(_audiosAll[i]);
        }
      }
      print(_audios.length);
      _stateSelect = CollectionsSelection.add;
      setState();
    } else if (_stateSelect == CollectionsSelection.add) {
      _audios = [];
      _stateSelect = CollectionsSelection.view;
      setState();
    } else if (_stateSelect == CollectionsSelection.editing) {
      _pathPhoto = null;
      _stateSelect = CollectionsSelection.viewItem;
      setState();
    } else if (_stateSelect == CollectionsSelection.viewItem) {
      _currentItem = null;
      _stateSelect = CollectionsSelection.view;
      setState();
    } else {
      _stateSelect = CollectionsSelection.view;
      setState();
    }
  }

  createCollection() async {
    if (controllerHeader.text.isNotEmpty) {
      if (controllerComment.text.isNotEmpty) {
        if (_pathPhoto != null && _pathPhoto != "") {
          Put response = await PlaylistProvider.create(
              controllerHeader.text, controllerComment.text, _pathPhoto);
          //todo complete create
          if (response.error == 200) {
            controllerComment.text = "";
            controllerHeader.text = "";
            _pathPhoto = null;
            updateData();

            back();
          } else {
            showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Не получилось создать плейлист, что-то пошло не так :(");
          }
        } else {
          showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Выберите обложку плейлиста");
        }
      } else {
        showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Некорректное описание плейлиста");
      }
    } else {
      //todo  no name
      showDialogIntegronError(AppKeys.scaffoldKey.currentContext, "Некорректное название плейлиста");
    }
  }

  backAndSave() async {
    showDialogLoading(AppKeys.scaffoldKey.currentContext);
    String c;
    String n;
    if(controllerComment.text !=""){c= controllerComment.text;}
    if(controllerHeader.text != ""){n= controllerHeader.text;}
    await PlaylistProvider.edit(_currentItem.id, imagePath: _pathPhoto, desc: c,name: n);
    closeDialog(AppKeys.scaffoldKey.currentContext);
    back();
    update();
  }

  Future addImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pathPhoto = (pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState();
  }

  setState() {
    CollectionsState state = CollectionsState(
        audios: _audios,
        currentItem: _currentItem,
        items: itemsCollection,
        stateSelect: _stateSelect,
        audiosSearch: _audiosSearch,
        audiosAll: _audiosAll);
    _behaviorSubject.sink.add(state);
    _behaviorSubjectPhoto.sink.add(_pathPhoto);
  }

  dispose() {
    _behaviorSubject.close();
    _behaviorSubjectPhoto.close();
  }
}
