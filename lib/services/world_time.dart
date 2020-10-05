import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  int isDay;
  String date;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      url = url.trim();
      Response response =
          await get("http://worldtimeapi.org/api/timezone/$url");
      print(url);
      Map data = jsonDecode(response.body);
      print(data);
      String datetime = data['datetime'];
      print(datetime);
      String offset = data['utc_offset'].substring(0, 3);

      List<String> division = data['utc_offset'].split(':');
      String minutes = offset[0] + division[1];
      print(offset);

      DateTime now = DateTime.parse(datetime);
      date = DateFormat.yMMMEd().format(now);

      now = now
          .add(Duration(hours: int.parse(offset), minutes: int.parse(minutes)));

      if (now.hour >= 6 && now.hour < 12) {
        isDay = 1;
      } else if (now.hour >= 12 && now.hour < 16) {
        isDay = 2;
      } else if (now.hour >= 16 && now.hour < 19) {
        isDay = 3;
      } else {
        isDay = 4;
      }

      time = DateFormat.jm().format(now);
      print(time);
    } catch (e) {
      print("Couldn't display time");
    }
  }
}
