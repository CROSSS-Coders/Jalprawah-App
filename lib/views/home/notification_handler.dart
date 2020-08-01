import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../services/index.dart';
import '../../components/general/index.dart';
import '../../components/subscription/index.dart';

class NotificationHandler extends StatefulWidget {
  @override
  _NotificationHandlerState createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  List<HandlerCard> damCards = [];
  SubscriptionService subscriptionService = new SubscriptionService();

  @override
  void initState() {
    _buildDamNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ScreenDrawer(),
      appBar: AppBar(
        flexibleSpace: BackgroundGradient(),
        title: Text('Manage Notifications'),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              child: Column(
                children: damCards,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildDamNotification() {
    var result = Hive.box('notification_dams').values;
    print('Notification dams: ' + result.toString());
    damCards = [];
    for (var dam in result) {
      print(dam);
      damCards.add(
        HandlerCard(
          key: ValueKey(dam['dam'].getDamID),
          damData: dam['dam'],
          removeDamCallback: _removeDam,
        ),
      );
    }
  }

  void _removeDam(HandlerCard child) {
    print(child.getDamID);
    List<int> deleteDam = [child.getDamID];
    subscriptionService.deleteDamSubscription(deleteDam).then((value) {
      print(value);
      setState(() {
        _buildDamNotification();
      });
    });
  }
}
