import 'package:cae_app/base/base_http.dart';
import 'package:cae_app/model/key.dart';
import 'package:cae_app/model/response_data.dart';

class KeyService extends HttpBase {
  KeyService(String token) : super(token);

  Future<List<Key>> list() async {
    return await get('/key')
        .then((data) => (data as List).map((i) => new Key.fromJson(i)).toList());
  }

  Future<ResponseData> add(dynamic model) async {
    return await post('/key', model.toString())
        .then((data) => ResponseData.fromJson(data));
  }
}