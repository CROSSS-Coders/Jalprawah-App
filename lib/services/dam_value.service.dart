import 'package:dio/dio.dart';

import '../utils/api.dart';
import '../models/index.dart';

class DamValueService {
  ApiBaseHelper api = new ApiBaseHelper();

  Future<DamValues> fetchDamInfo(damID) async {
    Response response = await api.get('/dams/' + damID.toString());
    var data = response.data;
    return DamValues.fromJson(damID, data);
  }
}
