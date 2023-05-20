import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_geolocation/ip_geolocation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  GeolocationData geolocationData;

  @override
  void initState() {
    super.initState();
    this.getIp();
  }

  Future<void> getIp() async {
    geolocationData = await GeolocationAPI.getData();
    if (geolocationData != null) {
      setState(() {
        text = geolocationData.ip;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(text),
              MaterialButton(
                  onPressed: () {
                    if (geolocationData != null) {
                      setState(() {
                        text = jsonEncode(geolocationData.toJson());
                      });
                    }
                  },
                  child: Text("toJSON"))
            ],
          ),
        ),
      ),
    );
  }
}
