import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'internet_connection.dart';

class RequestClient {
  factory RequestClient() {
    return _instance;
  }

  RequestClient._internal();

  static final RequestClient _instance = RequestClient._internal();
  http.Client _client = http.Client();

  static const String userAgent = 'User-Agent';
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';

  Future<Map<String, String>> _createCommonHeader() async {
    final common = <String, String>{};
    common[accept] = ContentType.json.toString();
    return common;
  }

  Future<Map<String, String>> _createHeader() async {
    final common = <String, String>{};
    common[contentType] = ContentType.json.toString();
    return common;
  }

  Future<http.Response> get(String url, Map<String, String> headers) async {
    var isInternet = await CheckInternetConnection().isInternet();
    debugPrint('-------------------------------');
    debugPrint('GET Request');
    debugPrint(url);
    debugPrint(headers.toString());
    debugPrint('-------------------------------');
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.get(Uri.parse(url), headers: headers);
      return response;
    } else {
      throw SocketException('No Internet Connection');
    }
  }

  Future<http.Response> post(
      String url, Map<String, String> headers, String body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    debugPrint('-------------------------------');
    debugPrint('POST Request');
    debugPrint(url);
    debugPrint(headers.toString());
    debugPrint('-------------------------------');
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      return response;
    } else {
      throw SocketException('No Internet Connection');
    }
  }

  Future<http.Response> postJson(
      String url, Map<String, String> headers, String body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    headers..addAll(await _createCommonHeader())..addAll(await _createHeader());
    if (isInternet) {
      final response = await _client.post(Uri.parse(url),
          headers: headers, body: body, encoding: Encoding.getByName('utf-8'));
      return response;
    } else
      throw SocketException('No Internet Connection');
  }

  Future<http.Response> put(
      String url, Map<String, String> headers, String body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.put(Uri.parse(url),
          headers: headers, body: body, encoding: Encoding.getByName('utf-8'));
      return response;
    } else
      throw SocketException('No Internet Connection');
  }

  Future<http.StreamedResponse> upload(http.MultipartRequest request) async {
    var isInternet = await CheckInternetConnection().isInternet();
    if (isInternet) {
      final response = await _client.send(request);
      return response;
    } else
      throw SocketException('No Internet Connection');
  }

  // Future<Response<dynamic>> dioUpload(
  //     String url, dio.FormData formData, Map<String, String> headers) async {
  //   var isInternet = await CheckInternetConnection().isInternet();
  //   final response = await dio.Dio().post(url,
  //       data: formData,
  //       options: Options(
  //           contentType: 'application/json',
  //           validateStatus: (status) => status! < 600,
  //           headers: headers));
  //   return response;
  // }

  Future<http.Response> delete(String url, Map<String, String> headers) async {
    var isInternet = await CheckInternetConnection().isInternet();
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.delete(Uri.parse(url), headers: headers);
      return response;
    } else
      throw SocketException('No Internet Connection');
  }

  Future<http.Response> patch(
      String url, Map<String, String> headers, String body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    headers.addAll(await _createCommonHeader());
    // DEBUG
    debugPrint('-------------------------------');
    debugPrint('PATCH Request');
    debugPrint(url);
    debugPrint(headers.toString());
    debugPrint(body);
    debugPrint('-------------------------------');
    if (isInternet) {
      final response = await _client.patch(Uri.parse(url),
          headers: headers, body: body, encoding: Encoding.getByName('utf-8'));
      return response;
    } else {
      throw SocketException('No Internet Connection');
    }
  }
}
