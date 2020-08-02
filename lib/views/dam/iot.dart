import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/dam.dart';

import '../../components/general/index.dart';
import '../../components/home/index.dart';
import '../../views/home/index.dart';

class IoT extends StatefulWidget {
  @override
  _IoTState createState() => _IoTState();
}

class _IoTState extends State<IoT> {
  DamInfo damInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ScreenDrawer(),
      appBar: AppBar(
        title: Text('JalPravah'),
        flexibleSpace: BackgroundGradient(),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Manage Notifications',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationHandler(),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: Hive.openBox('iot_dam'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(
                          'Oops! An error has occurred! Please try again later');
                    } else {
                      return ChartCard(
                        damData: Hive.box('iot_dam').get(34),
                        showButton: false,
                      );
                    }
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
                // child: ChartCard(
                //   damData: null,
                //   showButton: false,
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
