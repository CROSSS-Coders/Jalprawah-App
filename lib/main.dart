import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import 'utils/nearby.dart';
import 'utils/firebase.dart';
import 'utils/constants.dart';
import 'views/home/home.dart';
import './models/dam.dart';
import './views/auth/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  bool registered = await initHive();
  runApp(SIHNotifier(registered: registered));
}

Future<bool> initHive() async {
  Hive.registerAdapter(DamInfoAdapter());
  await Hive.openBox('user');
  await Hive.openBox('notification_dams');
  await Hive.openBox('chart_dams');
  await Hive.openBox('peers');
  bool registered = Hive.box('user').containsKey('id');
  return registered;
}

class SIHNotifier extends StatefulWidget {
  final bool registered;

  SIHNotifier({this.registered});

  @override
  _SIHNotifierState createState() => _SIHNotifierState();
}

class _SIHNotifierState extends State<SIHNotifier> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      print(data);
    }
    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
      print(notification);
    }
  }

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: " + message.toString());
        showSimpleNotification(
          Text(message['notification']['body']),
          background: kBlue,
        );
        await showDialog(
          context: scaffoldState.currentContext,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onBackgroundMessage: backgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: " + message.toString());
        showSimpleNotification(
          Text(message['notification']['body']),
          background: kBlue,
        );
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: " + message.toString());
        showSimpleNotification(
          Text(message['notification']['body']),
          background: kBlue,
        );
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
      Hive.box('user').put('fcmToken', token);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Roboto',
          backgroundColor: kBlue,
          primaryColor: kBlue,
          accentColor: kBlue,
        ),
        title: 'JalPravah',
        home: widget.registered ? Home() : Authentication(),
        // home: NearbyService(),
      ),
    );
  }
}
