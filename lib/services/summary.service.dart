import 'package:dio/dio.dart';

import '../utils/api.dart';
import '../models/index.dart';

class SummaryService {
  ApiBaseHelper api = new ApiBaseHelper();

  Future<Summary> fetchSummary() async {
    Response response = await api.get('/dams');
    var data = response.data['dams'];
    return Summary(
      total: data.length,
      normal: data.where((x) => x['status'] == 'Normal').length,
      warning: data.where((x) => x['status'] == 'Warning').length,
      danger: data.where((x) => x['status'] == 'Danger').length,
    );
  }
}
