import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_geolocation/ip_geolocation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  late GeolocationData geolocationData;

  @override
  void initState() {
    super.initState();
    this.getIp();
  }

  Future<void> getIp() async {
    geolocationData = await GeolocationAPI.getData();
    setState(() {
      text = geolocationData.ip ?? '';
    });
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
                  setState(() {
                    text = jsonEncode(geolocationData.toJson());
                  });
                },
                child: Text("toJSON"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
