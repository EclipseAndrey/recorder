import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recorder/DB/DBModel.dart';
import 'package:recorder/Utils/tokenDB.dart';
import 'package:recorder/models/AudioModel.dart';
import 'package:recorder/models/CollectionModel.dart';
import 'package:recorder/models/ProfileModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBProvider{
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database  = await _initDB();
    return _database;
  }

  Future<Database> _initDB()async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path  = dir.path+"base26.db";
    return await openDatabase(path, version: 1, onCreate : _createDB);
  }
  void _createDB (Database db, int version)async{
    await db.execute('CREATE TABLE ${TableUser.table} ( '
        '${TableUser.name} TEXT, '
        '${TableUser.free} TEXT, '
        '${TableUser.max} TEXT, '
        '${TableUser.picture} TEXT'
        ')',);
    await db.execute('CREATE TABLE ${TableAudio.table} ('
        '${TableAudio.id} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${TableAudio.name} TEXT, '
        '${TableAudio.desc} TEXT, '
        '${TableAudio.duration} TEXT,'
        '${TableAudio.createAt} TEXT,'
        '${TableAudio.updateAt} TEXT,'
        '${TableAudio.pathAudio} TEXT, '
        '${TableAudio.picture} TEXT,'
        '${TableAudio.isLocalPicture} INTEGER,'
        '${TableAudio.uploadPicture} INTEGER,'
        '${TableAudio.uploadAudio} INTEGER,'
        '${TableAudio.isLocalAudio} INTEGER,'
        '${TableAudio.idS} INTEGER '
        ')',);
    await db.execute('CREATE TABLE ${TableCollection.table} ('
        '${TableCollection.id} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${TableCollection.name} TEXT, '
        '${TableCollection.desc} TEXT, '
        '${TableCollection.duration} TEXT, '
        '${TableCollection.audios} TEXT, '
        '${TableCollection.picture} TEXT, '
        '${TableCollection.isLocalPicture} INTEGER,'
        '${TableCollection.uploadPicture} INTEGER,'
        '${TableCollection.idS} INTEGER'
        '${TableCollection.createAt} TEXT,'
        '${TableCollection.updateAt} TEXT'
        ')',);
  }

  Future<ProfileModel> profileGet()async{
    print('=== get l profile');
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(TableUser.name);
    String picture = prefs.getString(TableUser.picture);
    bool local  =  !await uploadProfilePhoto();
    print('$name $picture');
    return ProfileModel(picture: picture, name: name, phone: null, free: 500, max: 500, created_at: null, subscribe: null, updated_at: null, id: null, local: local);
  }
  Future<void> profileEdit({String name, String picture, bool isLocal})async{
    final prefs = await SharedPreferences.getInstance();
    if(name != null)prefs.setString(TableUser.name, name);
    if(picture != null){prefs.setString(TableUser.picture, picture);
    if(isLocal != null){prefs.setBool(TableUser.local, isLocal);}
    await uploadProfilePhoto(state: false);}
  }

  Future<List<AudioItem>> audiosGet()async{
    Database db = await this.database;
    final List<Map<String,dynamic>> list = await db.query(TableAudio.table);
    print("=== AudiosGet "+list.toString());
    List<AudioItem> listAudio = [];
    list.forEach((element) {
      listAudio.add(AudioItem.fromDB(element));
    });
    return listAudio;
  }

  Future<AudioItem> audioGet(int id, {int idS})async{
    Database db = await this.database;
    final List<Map<String,dynamic>> list = await db.query(TableAudio.table, where: "${idS == null?TableAudio.id:TableAudio.idS} = ?", whereArgs: [idS??id]);
    print("=== AudioGet $idS" + list.toString());

    AudioItem item;
    list.forEach((element) {item = AudioItem.fromDB(element);});
    return item;
  }

  Future<CollectionItem> collectionGet(int id)async{
    Database db = await this.database;
    final List<Map<String,dynamic>> list = await db.query(TableCollection.table, where: "${TableCollection.id} = ?", whereArgs: [id]);
    print("collectionGet " + list.toString());

    CollectionItem item = CollectionItem.fromDB(list[0]);
    List<AudioItem> audios = [];
    List<int> audiosIds = json.decode(list[0][TableCollection.audios]).cast<int>();
    for(int i = 0; i< audiosIds.length; i++){
      AudioItem step = await audioGet(audiosIds[i]);
      if(step!= null) audios.add(step);
      print("id audio "+step.id.toString());
    }
    item.playlist = audios;
    print(" === Collection ${item.playlist.length}");
    item.count = audios.length;
    int time = 0;
    for(int i = 0; i < audios.length; i++){
      time += audios[i].duration.inMilliseconds;
    }
    item.duration = Duration(milliseconds: time);
    return item;

  }

  Future<void>audioDelete(int id)async {
    Database db = await this.database;
    await db.delete(TableAudio.table, where: "${TableAudio.id} = ?", whereArgs: [id]);
  }

  Future<bool> audioEdit(int id, {
    String name,
    String picture,
    String desc,
    int ids,
    bool uploadAudio,
    bool isLocalPicture,
    bool uploadPicture,
    String pathAudio,
    bool isLocalAudio,
  })async{
    Database db = await this.database;
    if(name != null){
      await db.update(TableAudio.table, {TableAudio.name : name}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(picture != null){
      await db.update(TableAudio.table, {TableAudio.picture : picture}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(desc != null){
      await db.update(TableAudio.table, {TableAudio.desc : desc}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(pathAudio != null){
      await db.update(TableAudio.table, {TableAudio.pathAudio : pathAudio}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(ids != null){
      await db.update(TableAudio.table, {TableAudio.idS : ids}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(uploadAudio != null){
      await db.update(TableAudio.table, {TableAudio.uploadAudio : uploadAudio?1:0}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(isLocalPicture != null){
      await db.update(TableAudio.table, {TableAudio.isLocalPicture : isLocalPicture?1:0}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(uploadPicture != null){
      await db.update(TableAudio.table, {TableAudio.uploadPicture : uploadPicture?1:0}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    if(isLocalAudio != null){
      await db.update(TableAudio.table, {TableAudio.isLocalAudio : isLocalAudio?1:0}, where:"${TableAudio.id} = ?", whereArgs: [id]);
    }
    await db.update(TableAudio.table, {TableAudio.updateAt : DateTime.now().toString()}, where:"${TableAudio.id} = ?", whereArgs: [id]);
  }

  Future<int> audioAdd(AudioItem item)async{
    Database db = await this.database;
    item.createAt = DateTime.now();
    item.updateAt = DateTime.now();

    return (await db.insert(TableAudio.table, item.toMap()));
  }

  Future<List<CollectionItem>> collectionsGet()async{
    Database db = await this.database;
    final List<Map<String,dynamic>> list = await db.query(TableCollection.table);
    print("=== collectionsGet ${list}");
    List<CollectionItem> items = [];
    list.forEach((element)async {
      CollectionItem item = CollectionItem.fromDB(element);
      List<AudioItem> audios = [];
      List<int> audiosIds = (json.decode(element[TableCollection.audios])).cast<int>();
      for(int i = 0; i< audiosIds.length; i++){
        AudioItem a = await  audioGet(audiosIds[i]);
        if(a!= null) audios.add(a);
      }
      item.playlist = audios;
      item.count = audios.length;
      int time = 0;
      for(int i = 0; i < audios.length; i++){
        //time += audios[i].duration.inMilliseconds;
      }
      item.duration = Duration(milliseconds: time);
      items.add(item);
    });
    print("Db ${items.length} collections");
    return items;
  }
  Future<int> collectionAdd(CollectionItem item)async{
    Database db = await this.database;
    item.createAt = DateTime.now();
    item.updateAt = DateTime.now();
    return await db.insert(TableCollection.table, item.toMap());
  }
  Future<bool> collectionEdit(int id, { String name, String picture, String desc , int ids, bool isLocalPicture, bool uploadPicture })async{
    Database db = await this.database;
    if(name != null){
      await db.update(TableCollection.table, {TableCollection.name : name}, where:"${TableCollection.id} = ?", whereArgs: [id]);
    }
    if(picture != null){
      await db.update(TableCollection.table, {TableCollection.picture : picture}, where:"${TableCollection.id} = ?", whereArgs: [id]);
    }
    if(desc != null){
      await db.update(TableCollection.table, {TableCollection.desc : desc}, where:"${TableCollection.id} = ?", whereArgs: [id]);
    }
    if(ids != null){
      await db.update(TableCollection.table, {TableCollection.idS : ids}, where:"${TableCollection.id} = ?", whereArgs: [id]);
    }
    if(isLocalPicture != null){
      await db.update(TableCollection.table, {TableCollection.isLocalPicture : isLocalPicture}, where:"${TableCollection.id} = ?", whereArgs: [id]);
    }
    if(uploadPicture != null){
      await db.update(TableCollection.table, {TableCollection.uploadPicture : uploadPicture}, where:"${TableCollection.id} = ?", whereArgs: [id]);
    }
    await db.update(TableCollection.table, {TableCollection.updateAt : DateTime.now().toString()}, where:"${TableAudio.id} = ?", whereArgs: [id]);

  }

  Future<void>collectionDelete(int id)async {
    Database db = await this.database;
    await db.delete(TableCollection.table, where: "${TableCollection.id} = ?", whereArgs: [id]);
  }


  Future<void>collectionAddAudio(int id, int audioId)async {
    Database db = await this.database;
    print("Collection add audio");
    CollectionItem item = await collectionGet(id);
    bool find = false;
    for(int i = 0; i<item.playlist.length; i++){
      if(item.playlist[i].id == audioId)find = true;
    }
    if(!find){
     List<int> list = [];
     for(int i = 0; i<item.playlist.length; i++){
       list.add(item.playlist[i].id);
     }
     list.add(audioId);
     print("EDT PLAYLIST AAUDIO ${item.playlist.length}  ${json.encode(list)}");
     await db.update(TableCollection.table, {TableCollection.audios:json.encode(list)}, where: "${TableCollection.id} = ?", whereArgs: [id]);
    }
  }


  Future<void>collectionDeleteAudio(int id, int audioId)async {
    Database db = await this.database;
    CollectionItem item = await collectionGet(id);
    for(int i = 0; i<item.playlist.length; i++){
      if(item.playlist[i].id == audioId)item.playlist.removeAt(i);
    }
    List<int> list = [];
    for(int i = 0; i<item.playlist.length; i++){
      list.add(item.playlist[i].id);
    }
    await db.update(TableCollection.table, {TableCollection.audios:json.encode(list)}, where: "${TableCollection.id} = ?", whereArgs: [id]);
  }



}