import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String bgImage;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    data = data.isEmpty ? ModalRoute.of(context).settings.arguments : data;
    int check = data['DayTime'];
    print(data['DayTime']);
    print(data);
    if (check == 1) {
      bgImage = 'day.jfif';
      textColor = Colors.black;
    } else if (check == 2) {
      bgImage = 'afternoonnew.jfif';
      textColor = Colors.black;
    } else if (check == 3) {
      bgImage = 'eveningnew.jfif';
      textColor = Colors.white;
    } else {
      bgImage = 'night.jfif';
      textColor = Colors.white;
    }
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
          body: SafeArea(
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/$bgImage'),
                    fit: BoxFit.cover,
                  )),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                height: 350,
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.black.withAlpha(33),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () async {
                                          dynamic result =
                                              await Navigator.pushNamed(
                                                  context, '/location');
                                          setState(() {
                                            data = {
                                              'time': result['time'],
                                              'location': result['location'],
                                              'flag': result['flag'],
                                              'DayTime': result['DayTime'],
                                              'Date': result['Date']
                                            };
                                          });
                                        },
                                        icon: Icon(Icons.edit_location,
                                            color: textColor),
                                        label: Text(
                                          'Edit location',
                                          style: TextStyle(color: textColor),
                                        )),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          data['location'],
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 30.0,
                                            letterSpacing: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(data['time'],
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 50.0,
                                        )),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      data['Date'],
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 20.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]))))),
    );
  }
}
