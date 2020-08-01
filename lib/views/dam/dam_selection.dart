import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/dam.dart';
import '../../services/index.dart';
import '../../components/general/index.dart';
import '../../components/selector/index.dart';

class DamSelector extends StatefulWidget {
  @override
  _DamSelectorState createState() => _DamSelectorState();
}

class _DamSelectorState extends State<DamSelector> {
  final globalKey = GlobalKey<ScaffoldState>();
  DamService damService = new DamService();
  SubscriptionService subscriptionService = new SubscriptionService();

  Future<List<DamInfo>> damList;
  List<DamInfo> damInfoList;
  List<int> chartDams;
  List<int> notificationDams;
  bool checkedBox = false;

  _DamSelectorState();

  @override
  void initState() {
    var chartResults = Hive.box('chart_dams').values;
    chartResults = chartResults.map(
      (x) {
        return x.getDamID;
      },
    ).toList();
    chartDams = List<int>.from(chartResults);
    var notificationResults = Hive.box('notification_dams').values;
    notificationResults = notificationResults.map(
      (x) {
        return x['dam'].getDamID;
      },
    ).toList();
    notificationDams = List<int>.from(notificationResults);
    damList = damService.fetchDams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Select Dam'),
        flexibleSpace: BackgroundGradient(),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Container(
                child: FutureBuilder<List<DamInfo>>(
                  future: damList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      List<Widget> damsText = [];
                      print('Dam IDs in Dam Selector Chart: ' +
                          chartDams.toString());
                      print('Dam IDs in Dam Selector Notification: ' +
                          notificationDams.toString());
                      damInfoList = data;
                      for (int i = 0; i < data.length; i++) {
                        damsText.add(
                          SelectorCard(
                            damData: data[i],
                            addChartCallback: addChartCallback,
                            addNotificationCallback: addNotificationCallback,
                            chartValue: chartDams.length > 0
                                ? chartDams.contains(data[i].getDamID)
                                    ? true
                                    : false
                                : false,
                            notificationValue: notificationDams.length > 0
                                ? notificationDams.contains(data[i].getDamID)
                                    ? true
                                    : false
                                : false,
                          ),
                        );
                      }
                      damsText.add(
                        SizedBox(
                          height: 50,
                        ),
                      );
                      return Column(children: damsText);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: LoadingScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: checkedBox
          ? BottomSaveSheet(
              saveSelectionCallback: saveSelection,
            )
          : null,
    );
  }

  void saveSelection() async {
    List<dynamic> savedDams = Hive.box('notification_dams').values.toList();
    List<dynamic> newDamsID = notificationDams;
    List<dynamic> oldDamsID =
        savedDams.map((element) => element['dam'].getDamID).toList();
    List<dynamic> deleteDams =
        oldDamsID.where((element) => !newDamsID.contains(element)).toList();
    List<dynamic> toSaveDams =
        newDamsID.where((element) => !oldDamsID.contains(element)).toList();
    print(deleteDams.toString());
    print(toSaveDams.toString());
    var results = Hive.box('user').values.toList();
    var email = results[2];
    bool saveSuccess = await subscriptionService.updateSubscription(
        email, toSaveDams, deleteDams, damInfoList);
    if (!saveSuccess) {
      final snackBar = SnackBar(
        content: Container(
          height: 60,
          child: Text(
            'A network error has occurred, please try again.',
          ),
        ),
        duration: Duration(seconds: 5),
      );
      globalKey.currentState.showSnackBar(snackBar);
    }
    Navigator.pop(context);
  }

  void addChartCallback(damID, addToList) {
    DamInfo dam = damInfoList.where((x) => x.getDamID == damID).toList()[0];
    if (addToList) {
      chartDams.add(damID);
      Hive.box('chart_dams').put(damID, dam);
    } else {
      chartDams.remove(damID);
      Hive.box('chart_dams').delete(damID);
    }
    setState(() {
      checkedBox = true;
    });
    print('Checkbox checked: ' + Hive.box('chart_dams').values.toString());
  }

  void addNotificationCallback(damID, addToList) {
    if (addToList) {
      notificationDams.add(damID);
    } else {
      notificationDams.remove(damID);
    }
    setState(() {
      checkedBox = true;
    });
    print(
        'Checkbox checked: ' + Hive.box('notification_dams').values.toString());
    print(damID.toString() + ' ' + addToList.toString());
  }
}
