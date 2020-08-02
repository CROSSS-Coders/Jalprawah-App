import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class ApiBaseHelper {
  static final String url =
      'http://ec2-15-206-145-17.ap-south-1.compute.amazonaws.com';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: (RequestOptions options) => requestInterceptor(options),
            onError: (DioError e) async {
              return e.response.data;
            }),
      );
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    final results = Hive.box('user').values.toList();
    final token = results[0];
    print(token);
    options.headers.addAll({"Authorization": token});
    return options;
  }

  static final baseAPI = createDio();

  Future<dynamic> get(String url) async {
    var resData;
    try {
      final response = await baseAPI.get(url);
      resData = _returnResponse(response);
<<<<<<< HEAD
    } on SocketException {
      throw Exception('No Internet connection');
=======
    } on DioError catch (e) {
      print(e.message);
>>>>>>> d11398eb6b0e53dd69d06a294103fd692515a427
    }
    return resData;
  }

  Future<dynamic> post(String url, dynamic data) async {
    var resData;

    try {
      final response = await baseAPI.post(url, data: data);
      resData = _returnResponse(response);
<<<<<<< HEAD
    } on SocketException {
      throw Exception('No Internet connection');
=======
    } on DioError catch (e) {
      print(e.message);
>>>>>>> d11398eb6b0e53dd69d06a294103fd692515a427
    }
    return resData;
  }

  Future<dynamic> put(String url, dynamic data) async {
    var resData;
    try {
      final response = await baseAPI.put(url, data: data);
      resData = _returnResponse(response);
<<<<<<< HEAD
    } on SocketException {
      throw Exception('No Internet connection');
=======
    } on DioError catch (e) {
      print(e.message);
>>>>>>> d11398eb6b0e53dd69d06a294103fd692515a427
    }
    return resData;
  }

  Future<dynamic> delete(String url) async {
    var resData;
    try {
      final response = await baseAPI.delete(url);
      resData = _returnResponse(response);
<<<<<<< HEAD
    } on SocketException {
      throw Exception('No Internet connection');
=======
    } on DioError catch (e) {
      print(e.message);
>>>>>>> d11398eb6b0e53dd69d06a294103fd692515a427
    }
    return resData;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
