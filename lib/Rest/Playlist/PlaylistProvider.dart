import 'package:recorder/Models/CollectionModel.dart';
import 'package:recorder/models/Put.dart';
import 'package:recorder/Rest/API.dart';
import 'package:recorder/Rest/Rest.dart';
import 'package:recorder/Utils/tokenDB.dart';

class PlaylistProvider{
  static Future<List<CollectionItem>> get({int id}) async {
    String token = await  tokenDB();
    String urlQuery = urlConstructor(
        id != null ? Methods.audio.getUserAudio : Methods.playlist.get);
    Map <String, dynamic> body = Map();
    if (id != null) body['id'] = id;
    var response;
    response = await Rest.post(urlQuery, body, token: token);
    print(response.runtimeType);
    if (response.runtimeType.toString() ==  "Put") {
      Put r = response;
      if(r.error == 401){
        tokenDB(token: "null");
        return null;
      }
      return [];
    } else {
      return response.map((i) => CollectionItem.fromMap(i)).toList().cast<CollectionItem>();
    }
  }
}