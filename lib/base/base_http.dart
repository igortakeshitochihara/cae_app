import 'dart:async';

import 'package:async/async.dart';
import 'package:cae_app/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../settings.dart';

class HttpException {
  var message = '';
  var code = 0;

  HttpException({this.message, this.code});
}

class HttpStatus {
  static const OK = 200;
  static const BadRequest = 400;
  static const Unathorized = 401;
  static const ServerError = 500;
}

class HttpBase {
  var _token = '';

  //Dio _dio;

  HttpBase(this._token);

  getHeaders() {
    var header = new Map<String, String>();
    header['Content-Type'] = 'application/json';
    header['Accept'] = 'application/json';

    //print("TOKEN:" + _token);

    if (_token.isNotEmpty)
      header[HttpHeaders.authorizationHeader] = 'Bearer ' + _token;

    return header;
  }

  Future<dynamic> get(String url) {
    print("GET: $url");
    return http
        .get(Settings.baseURL + url, headers: getHeaders())
        .then((response) {
      print("RESPONSE CODE:" + response.statusCode.toString());
      print("RESPONSE:" + response.body);

      var data = json.decode(response.body);
      if (response.statusCode != HttpStatus.OK) {
        throw new HttpException(
            message: data['message'], code: response.statusCode);
      }
      //print(data);
      return data;
    });
  }

  Future<dynamic> post(String url, String _body) {
    print("POST: $url");
    print("BODY: $_body");
    return http
        .post(Settings.baseURL + url, body: _body, headers: getHeaders())
        .then((response) {
      //print("HEADER: " + _token);
      print("RESPONSE CODE:" + response.statusCode.toString());
      print("RESPONSE:" + response.body);
      var data = json.decode(response.body);
      if (response.statusCode != HttpStatus.OK) {
        throw new HttpException(
            message: data['message'], code: response.statusCode);
      }
      return data;
    });
  }

  Future<dynamic> put(String url, String _body) {
    print("PUT: $url");
    print("BODY: $_body");
    return http
        .put(Settings.baseURL + url, headers: getHeaders(), body: _body)
        .then((response) {
      print("RESPONSE CODE:" + response.statusCode.toString());
      print("RESPONSE:" + response.body);
      var data = json.decode(response.body);
      if (response.statusCode != HttpStatus.OK) {
        throw new HttpException(
            message: data['message'], code: response.statusCode);
      }
      return data;
    });
  }

  Future<dynamic> delete(String url) {
    print("DELETE: $url");
    return http
        .delete(Settings.baseURL + url, headers: getHeaders())
        .then((response) {
      print("RESPONSE CODE:" + response.statusCode.toString());
      print("RESPONSE:" + response.body);
      var data = json.decode(response.body);
      if (response.statusCode != HttpStatus.OK) {
        throw new HttpException(
            message: data['message'], code: response.statusCode);
      }
      return data;
    });
  }

  /*Future<dynamic> postFiles(String url, List<File> files) async {
    print("POST: $url");

    FormData form = new FormData();
    for (File file in files) {
      form.add("file", new UploadFileInfo(file, basename(file.path)));
    }

    // Options options = new Options();
    // options.headers["token"] = 'Bearer ' + _token;

    Dio _dio = new Dio(new Options(
        baseUrl: Settings.baseURL,
        headers: {"Authorization": 'Bearer ' + _token},
        connectTimeout: 5000,
        receiveTimeout: 3000));
    /*_dio.onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY opa.local:80";
      };
    };*/

    var response = await _dio.post(Settings.baseURL + url, data: form);

    print("RESPONSE CODE:" + response.statusCode.toString());
    print("RESPONSE:" + response.data);

    var data = json.decode(response.data);
    if (response.statusCode != HttpStatus.OK) {
      throw new HttpException(message: data['message'], code: response.statusCode);
    }
    return data;
  }*/

  Future<dynamic> postFiles(String url, List<File> files) async {
    print("POST: $url");

    var request =
    new http.MultipartRequest('POST', Uri.parse(Settings.baseURL + url));

    var header = new Map<String, String>();
    header['Content-Type'] = 'application/x-www-form-urlencoded';
    //header['Accept'] = 'application/json';

    if (_token.isNotEmpty)
      header[HttpHeaders.authorizationHeader] = 'Bearer ' + _token;

    request.headers.addAll(header);

    //files.asMap().forEach((i, file) async {
    var index = 0;
    for (var file in files) {
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      request.files.add(new http.MultipartFile('file$index', stream, length,
          filename: basename(file.path)));
      index++;
    }
    //);

    var response = await request.send();
    print("RESPONSE CODE:" + response.statusCode.toString());
    var _body = '';
    response.stream.transform(utf8.decoder).listen((result) => _body = result);
    print("RESPONSE:" + _body);
    var data = json.decode(_body);
    if (response.statusCode != HttpStatus.OK) {
      throw new HttpException(
          message: data['message'], code: response.statusCode);
    }
    return data;
  }
}
