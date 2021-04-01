part of 'API.dart';

class Methods {
  static _AuthMethods get auth => _AuthMethods();
  static _AudioMethods get audio => _AudioMethods();
  static _PlaylistMethods get playlist => _PlaylistMethods();
}

class _AuthMethods{
  String get sendCode => "send";
  String get checkCode => "auth";
}
class _AudioMethods{
  String get  upload => "upload";
  String get  get => "audio";
  String get  getUserAudio => "audios";
  String get  delete => "audio/delete";
}

class _PlaylistMethods{
  String get  get => "playlists";
  String getAudioFromPlaylist(int idPlaylist) => "playlist/$idPlaylist";
  String get  deleteAudio => "playlist/delete";
  String addTo(int idPlaylist) => "playlist/$idPlaylist/add";
  String deletePlaylist(int idPlaylist) => "playlist/$idPlaylist/delete";
}






