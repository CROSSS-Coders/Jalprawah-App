import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../utils/api.dart';

class AuthService {
  ApiBaseHelper api = new ApiBaseHelper();

  Future<bool> otpRequest(mobile) async {
    FormData formData = new FormData.fromMap({
      "mobile": mobile,
    });
    Response response = await api.post(
      '/login/',
      formData,
    );
    var data = response.data;
    if (data['message'] == 'otp sent')
      return true;
    else
      return false;
  }

  Future<Map<String, dynamic>> otpVerify(mobile, otp) async {
    FormData formData = new FormData.fromMap({
      "mobile": mobile,
      "otp": otp,
    });
    Response response = await api.post(
      '/login/verify',
      formData,
    );
    var data = response.data;
    if (data['status'] == 200) {
      Hive.box('user').putAll(data['user']);
      return data['user'];
    } else
      return null;
  }
}
