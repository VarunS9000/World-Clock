import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:world_clock/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  _LoadingState({this.yourLocation, this.yourURL});

  String time = "loading";
  String yourURL;
  String yourLocation;

  void setup() async {
    Response current = await get("http://worldtimeapi.org/api/ip");
    Map yourTimeZone = jsonDecode(current.body);
    yourURL = yourTimeZone["timezone"];
    List<String> yL = yourURL.split("/");
    yourLocation = yL[yL.length - 1];
    WorldTime instance =
        WorldTime(location: yourLocation, flag: 'clock.jfif', url: yourURL);
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'DayTime': instance.isDay,
      'Date': instance.date
    });
  }

  @override
  void initState() {
    super.initState();
    print('InitState function ran');
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ));
  }
}
