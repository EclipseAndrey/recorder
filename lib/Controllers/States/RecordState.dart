part of '../GeneralController.dart';
/*
0 - Не записывает
1 - записывает
2 - пауза
3 - стоп
 */

class RecordState{
  RecordingStatus  status;
  List<int> power;
  AudioItem audio;

  RecordState(this.status, this.power, {this.audio});
}