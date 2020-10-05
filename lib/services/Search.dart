import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';

class DataSearch extends SearchDelegate<String> {
  List<WorldTime> places;
  List<String> varun;

  String camelCase(String text) {
    if (text.length > 0) {
      return text[0].toUpperCase() + text.substring(1);
    }

    return "";
  }

  DataSearch({this.places});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<WorldTime> placesList = places
        .where(
            (element) => element.location.trim().startsWith(camelCase(query)))
        .toList();
    return ListView.builder(
        itemCount: placesList.length,
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
                onTap: () async {
                  WorldTime instance = placesList[index];
                  await instance.getTime();
                  Navigator.pushNamed(context, '/home', arguments: {
                    'location': instance.location,
                    'flag': instance.flag,
                    'time': instance.time,
                    'DayTime': instance.isDay,
                    'Date': instance.date
                  });
                },
                title: Text(placesList[index].location),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      AssetImage('assets/${placesList[index].flag}'),
                )),
          ));
        });
  }
}
