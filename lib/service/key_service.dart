import 'package:cae_app/base/base_http.dart';
import 'package:cae_app/model/key_model.dart';
import 'package:cae_app/model/response_data.dart';

class KeyService extends HttpBase {
  KeyService(String token) : super(token);

  Future<List<KeyModel>> list() async {
    return await get('/key').then(
        (data) => (data as List).map((i) => new KeyModel.fromJson(i)).toList());
  }

  Future<ResponseData> add(dynamic model) async {
    return await post('/key', model.toString())
        .then((data) => ResponseData.fromJson(data));
  }

  Future<ResponseData> update(dynamic model) async {
    return await put('/key', model.toString())
        .then((data) => ResponseData.fromJson(data));
  }

  Future<ResponseData> remove(String hash) async {
    return await delete('/key/$hash')
        .then((data) => ResponseData.fromJson(data));
  }
}
