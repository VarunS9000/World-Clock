import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_clock/services/world_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTime{
  String yourURL;
  String yourLocation;
  String yourTime;
  int IsDay;
  String time;
  String date;

  Future<void> setHomeTime() async{
    Response current = await get("http://worldtimeapi.org/api/ip");
    Map yourTimeZone = jsonDecode(current.body);
    yourURL = yourTimeZone["timezone"];
    List<String> yL = yourURL.split("/");
    yourLocation= yL[yL.length-1];
    yourTime=yourTimeZone['datetime'];
    String offset = yourTimeZone['utc_offset'].substring(0,3);
    List<String> divide = yourTimeZone['utc_offset'].split(':');

    String minutes= offset[0]+divide[1];

    DateTime yourNow = DateTime.parse(yourTime);
     date = DateFormat.yMMMEd().format(yourNow);

    yourNow = yourNow.add(Duration(hours: int.parse(offset),minutes: int.parse(minutes) ));
    time=DateFormat.jm().format(yourNow);
    print(time);

    if(yourNow.hour>=6 && yourNow.hour<12){
      IsDay=1;
    }

    else if(yourNow.hour>=12 && yourNow.hour<16){
      IsDay=2;
    }

    else if(yourNow.hour>=16 && yourNow.hour<19){
      IsDay=3;
    }

    else{
      IsDay=4;
    }


  }






   }

