import 'package:cae_app/base/base_http.dart';
import 'package:cae_app/model/response_data.dart';

class BorrowingService extends HttpBase {
  BorrowingService(String token) : super(token);

  Future<ResponseData> borrowing(String hash) async {
    return await post('/borrowing/$hash', null)
        .then((data) => ResponseData.fromJson(data));
  }

  Future<ResponseData> returnKey(String hash) async {
    return await put('/borrowing/$hash', null)
        .then((data) => ResponseData.fromJson(data));
  }
}