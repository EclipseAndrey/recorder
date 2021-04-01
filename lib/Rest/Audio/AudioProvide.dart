import 'package:dio/dio.dart';
import 'package:recorder/Models/AudioModel.dart';
import 'package:recorder/Models/Put.dart';
import 'package:recorder/Rest/API.dart';
import 'package:recorder/Rest/Rest.dart';
import 'package:recorder/Utils/tokenDB.dart';

class AudioProvider {
  static Future<List<AudioItem>> get({int id}) async {
    String token = await  tokenDB();
    String urlQuery = urlConstructor(
        id == null ? Methods.audio.getUserAudio : Methods.audio.get);
    Map <String, dynamic> body = Map();
    if (id != null) body['id'] = id;
    var response;
    response = await Rest.post(urlQuery, body, token: token);
    if (response.runtimeType.toString() ==  "Put") {
      Put r = response;

      if(r.error == 401){
        tokenDB(token: "null");
        return null;
      }
      return [];
    } else {
      return response.map((i) => AudioItem.fromMap(i)).toList().cast<AudioItem>();
    }
  }

  static Future<Put> delete(int id) async {
    String urlQuery = urlConstructor(Methods.audio.delete);
    String token = await  tokenDB();

    Map <String, dynamic> body = Map();
    body['id'] = id;
    var response;
    response = await Rest.post(urlQuery, body,token:token);
    if (response is Put) {
      return response;
    } else {
      return Put(error: 200, mess: "ok", localError: false);
    }
  }


}