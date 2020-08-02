import 'package:dio/dio.dart';
import 'package:flutter_pusher/pusher.dart';

import '../models/iot.dart';
import '../utils/api.dart';

class IOTPusher {
  ApiBaseHelper api = new ApiBaseHelper();

  Future<Channel> initPusher() async {
    try {
      await Pusher.init(
        "d121a0e4fc8e52e1b0ab",
        PusherOptions(
          cluster: "ap2",
        ),
        enableLogging: true,
      );
      Channel channel = await Pusher.subscribe('iot');
      return channel;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<dynamic> fetchIOTInfo() async {
    Response response = await api.get('/iot');
    var data = response.data;
    return IOTValues.fromJson(data);
  }
}
