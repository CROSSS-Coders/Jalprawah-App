import 'package:flutter/material.dart';

class DrawerItems extends StatelessWidget {
  final String name;
  final Icon icon;
  final Widget screen;

  DrawerItems({this.name, this.icon, this.screen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          this.icon,
          Container(
            width: 5,
          ),
          Text(
            this.name,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => this.screen),
        );
      },
    );
  }
}
