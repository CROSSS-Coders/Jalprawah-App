import 'package:flutter/material.dart';

import '../../components/general/index.dart';
import '../../components/home/index.dart';
import '../../views/home/index.dart';

class IoT extends StatefulWidget {
  @override
  _IoTState createState() => _IoTState();
}

class _IoTState extends State<IoT> {
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
