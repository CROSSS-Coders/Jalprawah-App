import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import './drawer_items.dart';
import '../../views/home/index.dart';
import '../../views/dam/index.dart';
import '../../utils/constants.dart';

class ScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kBlue, kDarkBlue],
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GFDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          DrawerItems(
            name: 'Home',
            icon: Icon(Icons.home, color: Colors.white),
            screen: Home(),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
          DrawerItems(
            name: 'IoT',
            icon: Icon(
              Icons.cloud,
              color: Colors.white,
            ),
            screen: IoT(),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
          DrawerItems(
            name: 'Flood Summary',
            icon: Icon(
              Icons.assessment,
              color: Colors.white,
            ),
            screen: FloodSummary(),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
          DrawerItems(
            name: 'Notifications',
            icon: Icon(Icons.notifications, color: Colors.white),
            screen: NotificationHandler(),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
