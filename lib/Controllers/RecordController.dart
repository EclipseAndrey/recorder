import 'dart:async';
import 'dart:io' as io;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:recorder/Controllers/CollectionsController.dart';
import 'package:recorder/Controllers/States/PlayerState.dart';
import 'package:recorder/Rest/Audio/AudioProvide.dart';
import 'package:recorder/Utils/app_keys.dart';
import 'package:recorder/models/AudioModel.dart';
import 'package:recorder/models/Put.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:file/local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recorder/Controllers/GeneralController.dart';

class RecordController{
  FlutterAudioRecorder _recorder;
  Recording _current;
  LocalFileSystem _localFileSystem;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  // final _streamControllerRecord = StreamController<RecordState>.broadcast();
  get streamRecord => _behaviorSubject.stream;

  TextEditingController textEditingControllerName =TextEditingController();
  TextEditingController textEditingControllerDesc =TextEditingController();

  List<int> _powerList;
  BehaviorSubject _behaviorSubject = BehaviorSubject<RecordState>();

  bool _loading = false;

  bool _loadingPLayer;
  int maxPower;
  int bufferPowerSize;

  Timer _timer;
  int _uploadIndex;


  AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration;
  Duration _maxDuration;
  bool _finding;
  AudioPlayerState _playerState;

  bool _open = false;


  RecordController(){
    _initPlayer();
  }


  recordStart(int bufferSize )async{
    _uploadIndex = null;
    _open = true;
    maxPower = 70;
    _powerList = [];
    bufferPowerSize = bufferSize;
    for(int i = 0; i < bufferPowerSize; i++){
      _powerList.add(0);
    }

    print("RecordStart");
    if(await _init()) {
      await _start();
      _timer = Timer.periodic(Duration(milliseconds: 300), (Timer t) async {
        _current = await _recorder.current(channel: 0);
        print(_current.status);
        _powerList.removeAt(0);
        // if(maxPower != null && maxPower < _recorder.recording.metering.peakPower.toInt().abs()){
        //   maxPower = _recorder.recording.metering.peakPower.toInt().abs();
        // }
        _powerList.add(maxPower + _recorder.recording.metering.averagePower.toInt());
        print(( _recorder.recording.metering.averagePower.toInt()).toString() +" " + maxPower.toString());


        setState();
      });
    }

  }
  recordPause()async{
    _recorder.pause();
    _timer.cancel();
    _current = await _recorder.current(channel: 0);
    setState();
  }
  recordStop()async{
    ////////////////////////////////////////////////////0000000000000000000000000000000000000000000000000000000000000000000000
    _recorder.stop();
    _timer.cancel();
    try{stop();}catch(e){}
    _current = await _recorder.current(channel: 0);
    _audioPlayer.setUrl(_current.path, isLocal: true);

    setState();


  }

  tapButtonPlayer()async{
    if(_playerState == AudioPlayerState.PLAYING){
      pause();
    }else if(_playerState == AudioPlayerState.PAUSED){
      resume();
    }else{
      play();
    }
  }



  tapPause(CollectionsController collectionsController)async{
    await recordPause();
    await recordStop();
    textEditingControllerDesc.text = "";
    String out = "Аудиозапись ";
    bool find = false;
    int counter = 1;
    do{
      find = false;
      for(int i = 0; i < collectionsController.audiosAll.length; i++){
        print("${collectionsController.audiosAll[i].name}  ${out+counter.toString()}  " );
        if(collectionsController.audiosAll[i].name.contains(out+counter.toString())){
          find = true;
          break;
        }
      }
      if(find) counter++;
    }while(find);
    out+=counter.toString();

    textEditingControllerName.text = out;
  }

  closeSheet()async{
    //todo
    _open = false;
    stop();
    recordStop();
  }


  Future<bool>_init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/audios';
        io.Directory appDocDirectory;
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        _current = current;
        _currentStatus = current.status;
        print(_currentStatus);
        return true;


      } else {
        //todo no permission
        print("No permission");

      }
    } catch (e) {
      print(e);
    }
    return false;

  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      _current = recording;
      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);

        _current = current;
        _currentStatus = _current.status;

      });
    } catch (e) {
      print(e);
    }
  }

  _initPlayer(){
    ///MAX
    _audioPlayer.onDurationChanged.listen((Duration d) {
      _maxDuration = d;
      _loadingPLayer = false;
      setState();
      print("player record max completed ${_maxDuration.inSeconds}");
    });

    ///Current
    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      if(_finding == null || !_finding)_currentDuration = p;
      setState();
    });

    ///Status
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      _playerState = s;
      if(s == AudioPlayerState.COMPLETED){
        _currentDuration = _maxDuration;
      }
      setState();
    });
    _audioPlayer.onPlayerCompletion.listen((event) {
      setState();
    });
  }

  play() async {
    print("play ${_current.path}");


    print("PLAYER RECORD STATE  ====================  "+_audioPlayer.state.toString());
    if(_audioPlayer.state == AudioPlayerState.PAUSED) {
      int result = await _audioPlayer.play(_current.path, isLocal: true);
      if (result == 1) {
        _loadingPLayer = true;
      } else {

      }
      setState();
    }else{
      _audioPlayer.resume();
    }
  }
  pause(){
    _audioPlayer.pause();
  }
  stop(){
    _audioPlayer.stop();
  }

  resume(){
    _audioPlayer.resume();
  }
  next(){
    stop();
  }

  seek(Duration duration){
    _finding = false;
    _currentDuration = duration;
    _audioPlayer.seek(duration);
  }

  setDuration(Duration duration){
    _finding  = true;
    _currentDuration = duration;
    setState();
  }

  save()async{
    //todo save

    if(!_loading) {
      _loading  = true;
      setState();
      String name = textEditingControllerName.text;
      String desc = textEditingControllerDesc.text;
      String path = _recorder.recording.path;
      int duration = _recorder.recording.duration.inMilliseconds;
      if (textEditingControllerName.text.isEmpty) name = "Аудиозапись 1";
      if (textEditingControllerDesc.text.isEmpty) desc = "Описание";
      int res =await AudioProvider.createLocal(name, desc, duration, path, ids: _uploadIndex);
      _loading = false;
      setState();
      if(res !=null && _open){
        Navigator.pop(AppKeys.scaffoldKey.currentState.context);
      }
    }
  }
  saveLocal()async{

  }
  share()async{
    if(!_loading && _uploadIndex == null) {
      _loading  = true;
      setState();
      String name = textEditingControllerName.text;
      String desc = textEditingControllerDesc.text;
      String path = _recorder.recording.path;
      int duration = _recorder.recording.duration.inMilliseconds;
      if (textEditingControllerName.text.isEmpty) name = "Аудиозапись 1";
      if (textEditingControllerDesc.text.isEmpty) desc = "Описание";
      _uploadIndex = await AudioProvider.upload(0, audioItem:  AudioItem(name: name, description: desc, duration: Duration(milliseconds:duration ), pathAudio: path, picture: null));
      _loading = false;
      setState();
    }
  }

  delete(){
    //todo delete
  }




  setState(){
    _behaviorSubject.sink.add(RecordState(_current.status, _powerList, _current.duration, maxPower, loading: _loading, playerState: PlayerState(item: null, state: _playerState, playing: true, current: _currentDuration, max: _maxDuration, loading: _loadingPLayer, )));
  }

  dispose(){
    _behaviorSubject.close();
    // _streamControllerRecord.close();
  }

}
