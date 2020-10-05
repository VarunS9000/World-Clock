import 'package:flutter/material.dart';
import 'dart:io';
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
        // ignore: missing_return
      onWillPop:  showModalBottomSheet(context: context, builder: (context){
        return Container(
          decoration: BoxDecoration(
              color: Colors.transparent
          ),
          height: 100,
          width: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                  ),
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 20, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Do you really want to exit?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        FlatButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          color: Colors.black,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                letterSpacing: 1
                            ),
                          ),
                        ),
                        SizedBox(width: 25,),
                        FlatButton(
                          onPressed: (){
                            exit(0);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          color: Colors.white30,
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } ),
      child: Scaffold(
          body: SafeArea(
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/$bgImage'),
                        fit: BoxFit.cover,
                      )),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 120.0, 0, 0),
                      child: Column(children: <Widget>[
                        FlatButton.icon(
                            onPressed: () async {
                              dynamic result =
                              await Navigator.pushNamed(context, '/location');
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
                            icon: Icon(
                              Icons.edit_location,
                              color: textColor,
                            ),
                            label: Text(
                              'Edit location',
                              style: TextStyle(color: textColor),
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ])))))
    );
  }
}
