import 'package:cae_app/base/base_http.dart';
import 'package:cae_app/model/response_data.dart';
import 'package:cae_app/model/room.dart';

class RoomService extends HttpBase {
  RoomService(String token) : super(token);

  Future<List<Room>> list() async {
    return await get('/room').then(
        (data) => (data as List).map((i) => new Room.fromJson(i)).toList());
  }

  Future<ResponseData> add(dynamic model) async {
    return await post('/room', model.toString())
        .then((data) => ResponseData.fromJson(data));
  }

  Future<ResponseData> remove(String hash) async {
    return await delete('/room/$hash')
        .then((data) => ResponseData.fromJson(data));
  }
}
