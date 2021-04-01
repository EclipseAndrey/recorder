import 'dart:async';

import 'dart:io' as io;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recorder/Controllers/HomeController.dart';
import 'package:recorder/Controllers/LoginController.dart';
import 'package:recorder/Controllers/ProfileController.dart';
import 'package:flutter/services.dart';
import 'package:file/local.dart';
import 'package:recorder/Models/AudioModel.dart';


part 'States/RecordState.dart';



class GeneralController{
  ///Home
  HomeController homeController ;

  ///Profile
  ProfileController profileController;

  ///General
  FlutterAudioRecorder _recorder;
  Recording _current;
  AudioPlayer audioPlayer = AudioPlayer();
  LocalFileSystem localFileSystem;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  final _streamControllerRecord = StreamController<RecordState>.broadcast();
  get streamRecord => _streamControllerRecord.stream;

  GeneralController(){
    print('INIT GENERAL CONTROLLER');
    this.profileController = ProfileController();
    this.homeController = HomeController();
  }








  recordStart(){
    _streamControllerRecord.sink.add(RecordState(RecordingStatus.Recording, []));
  }
  recordPause(){
    _streamControllerRecord.sink.add(RecordState(RecordingStatus.Paused, []));

  }
  recordStop(){
    _streamControllerRecord.sink.add(RecordState(RecordingStatus.Stopped, []));
  }


  _init() async {
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


      } else {
       //todo no permission
      }
    } catch (e) {
      print(e);
    }
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


  dispose(){
    _streamControllerRecord.close();
  }


}