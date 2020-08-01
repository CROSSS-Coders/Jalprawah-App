import 'package:dio/dio.dart';

import '../utils/api.dart';
import '../models/index.dart';

class DamService {
  ApiBaseHelper api = new ApiBaseHelper();

  Future<List<DamInfo>> fetchDams() async {
    Response response = await api.get('/dams');
    List<DamInfo> damList = [];
    var data = response.data;
    for (int i = 0; i < data['dams'].length; i++) {
      if (data['dams'][i]['id'] == 34) {
        continue;
      }
      damList.add(DamInfo.fromJson(data['dams'][i]));
    }
    return damList;
  }
}
