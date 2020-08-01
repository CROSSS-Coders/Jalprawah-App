import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../components/general/index.dart';
import '../../components/home/index.dart';
import '../../views/dam/index.dart';
import './notification_handler.dart';
import '../../models/dam.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ChartCard> damCharts = [];

  @override
  void initState() {
    _buildDamCharts();
    super.initState();
  }

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
            child: Column(
              children: damCharts,
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DamSelector()),
          ).then((value) => _buildDamCharts());
        },
      ),
    );
  }

  void _buildDamCharts() {
    var result = Hive.box('chart_dams').values;
    print('Chart dams: ' + result.toString());

    damCharts = [];
    for (DamInfo dam in result) {
      damCharts.add(ChartCard(
        key: ValueKey(dam.getDamID),
        damData: dam,
        removeDamCallback: removeDam,
      ));
    }
  }

  void removeDam(ChartCard child) {
    setState(() {
      this.damCharts.removeWhere((element) => element.key == child.key);
      Hive.box('chart_dams').delete(child.getDamID);
    });
  }
}
