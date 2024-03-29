// ignore_for_file: implementation_imports, no_leading_underscores_for_library_prefixes, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;
import 'package:http/http.dart' as _http;
import 'package:http_parser/src/media_type.dart';
import 'package:smartpay/service/remote/api_endpoints.dart';
import 'package:smartpay/view_models/share_preference_vm.dart';

HttpService http = HttpService();

class HttpService {
  final timeOutSeconds = 30;
  Map<String, String>? header(bool addAuth, [bool passReset = false]) {
    final Map<String, String> header;
    if (addAuth) {
      header = _token != null
          ? {
              "Accept": "application/json",
              "Authorization": "Bearer $_token",
              if (passReset) "x-password-reset": "Bearer $_token",
            }
          : {"Accept": "application/json"};
    } else {
      header = {"Accept": "application/json"};
    }

    log('HEADER---$header');

    return header;
  }

  String? _token;

  setToken(String? value)async {

    _token = value;
  }

  error401() {
    // ref.read(authViewModel).onLogOut();
  }
 



  Future post({
    required String path,
    required data,
    bool addAuth = true,
    bool check401 = true,
    bool passwordReset = false,
  }) async {
    _http.Response? response;
    try {
      final url = Uri.parse(ApiEndPoints.baseUrl + path);
      log('POST---$url');
      log('POST---DATA---$data');

      response = await _http.post(
        url,
        body: (data),
        headers: header(addAuth, passwordReset),
      );
      log('Status Code:${response.statusCode}\n Result: ${response.body}');
      if (check401 && response.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['success'] = false;
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (response.body.isEmpty) {
        return <String, dynamic>{};
      }
      return json.decode(response.body);
    } catch (exception) {
      log('Error: ${exception.runtimeType}');
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '000';
      data['message'] = exception is TimeoutException
          ? 'Connection Timed Out, Try Again'
          : 'Error Processing response';
      return data;
    }
  }

  Future get({
    required String path,
    String? id,
    bool addAuth = true,
    bool check401 = true,
  }) async {
    _http.Response? response;
    try {
      final url =
          Uri.parse(ApiEndPoints.baseUrl + path + (id != null ? '/$id' : ''));
      log('GET---$url');

      response = await _http.get(
        url,
        headers: header(addAuth),
        
      );
      log('Status Code:${response.statusCode}\n Result: ${response.body}');
      if (check401 && response.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (response.body.isEmpty) {
        return <String, dynamic>{};
      }
      return json.decode(response.body);
    } catch (exception) {
      log('Error: $exception');

      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '000';
      data['message'] = 'Error Processing response';
      return data;
    }
  }

  Future patch({
    required String path,
    String? id,
    bool addAuth = true,
    bool check401 = true,
  }) async {
    _http.Response? response;
    try {
      final url =
          Uri.parse(ApiEndPoints.baseUrl + path + (id != null ? '/$id' : ''));
      log('GET---$url');

      response = await _http.patch(
        url,
        headers: header(addAuth),
      );
      log('Status Code:${response.statusCode}\n Result: ${response.body}');
      if (check401 && response.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (response.body.isEmpty) {
        return <String, dynamic>{};
      }
      return json.decode(response.body);
    } catch (exception) {
      log('Error: $exception');

      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '000';
      data['message'] = 'Error Processing response';
      return data;
    }
  }

  Future getBytes({
    required String path,
    String? id,
    bool addAuth = true,
    bool check401 = true,
  }) async {
    _http.Response? response;
    try {
      final url =
          Uri.parse(ApiEndPoints.baseUrl + path + (id != null ? '/$id' : ''));
      log('GET---$url');

      response = await _http.get(
        url,
        headers: header(addAuth),
      );
      log('Status Code:${response.statusCode}\n Result: ${response.body}');

      if (check401 && response.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (check401 && response.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (response.body.isNotEmpty && response.statusCode != 400) {
        return response.body;
      }
      return json.decode(response.body);
    } catch (exception) {
      log('Error: $exception');

      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '000';
      data['message'] = 'Error Processing response';
      return data;
    }
  }

  Future put({
    required String path,
    var data,
    bool addAuth = true,
    bool check401 = true,
  }) async {
    _http.Response? response;
    try {
      final url = Uri.parse(ApiEndPoints.baseUrl + path);
      log('PUT---$url');
      log('PUT---DATA---$data');

      response = await _http.put(
        url,
        body: data == null ? null : jsonEncode(data),
        headers: header(addAuth),
      );
      log('Status Code:${response.statusCode}\n Result: ${response.body}');
      if (check401 && response.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (response.body.isEmpty) {
        return <String, dynamic>{};
      }
      return json.decode(response.body);
    } catch (exception) {
      log('Error: ${exception.runtimeType}');
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '000';
      data['message'] = exception is TimeoutException
          ? 'Connection Timed Out, Try Again'
          : 'Error Processing response';
      return data;
    }
  }

  Future delete({
    required String path,
     data,
    String? id,
    bool addAuth = true,
    bool check401 = true,
  }) async {
    _http.Response? response;
    try {
      final url =
          Uri.parse(ApiEndPoints.baseUrl + path + (id != null ? '/$id' : ''));
      log('DELETE---$url');
      log("data:-- $data");

      response = await _http.delete(
        url,
         body: jsonEncode(data),
        headers: header(addAuth),
      );
      log('Status Code:${response.statusCode}\n Result: ${response.body}');
      if (check401 && response.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (response.body.isEmpty) {
        return <String, dynamic>{};
      }
      return json.decode(response.body);
    } catch (exception) {
      log('Error: $exception');

      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '000';
      data['message'] = 'Error Processing response';
      return data;
    }
  }

  Future uploadFile({
    String requestType = 'PUT',
    required String path,
    required List<FileData> files,
    required Map<String, dynamic> data,
    bool check401 = true,
    bool addAuth = true,
  }) async {
    dynamic parsedJson;
    try {
      final url = Uri.parse(ApiEndPoints.baseUrl + path);
      log('UPLOAD---$requestType---$url');

      final request = _http.MultipartRequest(
        requestType,
        url,
      );
      log("the req:  $request");
      if (addAuth) {
        request.headers['Authorization'] = 'Bearer $_token';
      }
      request.headers['Content-Type'] = 'multipart/form-data';
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      for (var item in files) {
        log('${item.ioFileDataPath}=====${item.ioFile.path}');
        _http.MultipartFile multipartFile = await _http.MultipartFile.fromPath(
          item.ioFileDataPath,
          item.ioFile.path,
          contentType: MediaType('${item.fileType}', '${item.extension}'),
        );

        request.files.add(multipartFile);
      }
      log('TOKEN: ${request.headers['Authorization']}');
      log('DATA: ${request.fields}');
      var resp = await request.send();
      String response = await resp.stream.bytesToString();

      log('STATUS CODE: ${resp.statusCode}');
      log('RESPONSE: $response');
      if (check401 && resp.statusCode == 401) {
        error401();
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = '401';
        data['message'] = 'Access Forbidden,Contact Support';
        return data;
      }
      if (response.isEmpty) {
        return <String, String>{};
      }
      if (response.contains('<html>')) {
        var res = <String, String>{};
        res['code'] = '00';
        res['message'] = 'Error Occurred';
        return res;
      }

      parsedJson = await json.decode(response);

      return parsedJson;
    } catch (exception) {
      log('Error: $exception');
      log('RESPONSE:  $parsedJson');

      var res = <String, String>{};
      res['code'] = '90';
      res['message'] = 'Error Occurred $exception';
      return res;
    }
  }
}

class FileData {
  final io.File ioFile;
  final String ioFileDataPath;
  String? extension;
  String? fileType;

  FileData({
    required this.ioFile,
    required this.ioFileDataPath,
    this.extension = 'png',
    this.fileType = 'image',
  });
}
