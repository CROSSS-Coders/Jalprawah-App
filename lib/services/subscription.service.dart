import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';

import '../utils/api.dart';
import '../models/index.dart';

class SubscriptionService {
  ApiBaseHelper api = new ApiBaseHelper();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<bool> updateSubscription(
      email, saveDams, deleteDams, damInfoList) async {
    print('Inside function: ' + saveDams.toString());
    print('Inside function: ' + deleteDams.toString());
    bool saveResponse = await saveDamSubscription(email, saveDams, damInfoList);
    bool deleteResponse = await deleteDamSubscription(deleteDams);
    return saveResponse & deleteResponse;
  }

  Future<bool> deleteDamSubscription(deleteDams) async {
    for (int damID in deleteDams) {
      var hiveResults = Hive.box('notification_dams').get(damID);
      await api.delete(
        '/login/subscibe/${hiveResults['id']}/delete',
      );
      Hive.box('notification_dams').delete(damID);
      _firebaseMessaging.unsubscribeFromTopic(damID.toString());
    }
    return true;
  }

  Future<bool> saveDamSubscription(email, saveDams, damInfoList) async {
    for (int damID in saveDams) {
      FormData formData = new FormData.fromMap({
        'dam_id': damID.toString(),
        'em': email == null ? 'false ' : 'true',
        'email': email == null ? '' : email,
        'mo': 'true',
        'pu': 'true'
      });
      Response response = await api.post('/login/create/subscribe', formData);
      var data = response.data;
      DamInfo dam = damInfoList.where((x) => x.getDamID == damID).toList()[0];
      Hive.box('notification_dams').put(
        damID,
        {
          'dam': dam,
          'id': data['subscribe']['id'],
        },
      );
      _firebaseMessaging.subscribeToTopic(damID.toString());
    }
    return true;
  }
}
