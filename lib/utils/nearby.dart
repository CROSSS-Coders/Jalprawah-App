import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nearby_connections/nearby_connections.dart';

class NearbyService extends StatefulWidget {
  const NearbyService({Key key}) : super(key: key);

  @override
  _NearbyServiceState createState() => _NearbyServiceState();
}

class _NearbyServiceState extends State<NearbyService> {
  final Strategy strategy = Strategy.P2P_CLUSTER;
  Box peers = Hive.box('peers');
  final String userID = Random().nextInt(10000).toString();

  @override
  void initState() {
    Nearby().askLocationAndExternalStoragePermission();
    startAdvertising();
    super.initState();
  }

  void startAdvertising() async {
    try {
      bool adv = await Nearby().startAdvertising(
        userID,
        strategy,
        onConnectionInitiated: (id, info) async {
          acceptConnection(id);
        },
        onConnectionResult: (id, status) {
          print(status);
          if (status == Status.CONNECTED) {
            peers.put(id, id);
          }
        },
        onDisconnected: (id) {
          peers.delete(id);
          print('Disconnected $id');
        },
      );
      print('ADVERTISING ${adv.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void startDiscovery() async {
    try {
      bool dis = await Nearby().startDiscovery(userID, strategy,
          onEndpointFound: (id, name, serviceId) async {
        print(id);
        Nearby().requestConnection(
          userID,
          id,
          onConnectionInitiated: (id, info) async {
            acceptConnection(id);
          },
          onConnectionResult: (id, status) {
            print(status);
            if (status == Status.CONNECTED) {
              peers.put(id, id);
            }
          },
          onDisconnected: (id) {
            peers.delete(id);
            print("Disconnected: " + id);
          },
        );
      }, onEndpointLost: (id) {
        print("Lost: " + id);
      });
      print('DISCOVERING: ${dis.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void acceptConnection(id) async {
    Nearby().acceptConnection(
      id,
      onPayLoadRecieved: (endid, payload) async {
        String str = String.fromCharCodes(payload.bytes);
        print(endid + ": " + str);
      },
    );
  }

  void _sendData() async {
    String warning = 'WARNING';
    for (var peer in peers.values) {
      Nearby().sendBytesPayload(peer, Uint8List.fromList(warning.codeUnits));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Find and Connect'),
              onPressed: startDiscovery,
            ),
            FlatButton(
              child: Text('Send Data'),
              onPressed: _sendData,
            ),
          ],
        ),
      ),
    );
  }
}
