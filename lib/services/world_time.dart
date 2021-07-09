import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location for UI
  String time;
  String flag; // Url to asset image
  String url; // location url for api
  bool isDay = false;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['datetime'];
      String offsetHours = data['utc_offset'].substring(1, 3);
      String offsetMinutes = data['utc_offset'].substring(4,6);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));
      // print(now);

      isDay = now.hour > 6 && now.hour <20 ? true : false ;
      time = DateFormat.jm().format(now); //Set Time property
    }
    catch(e){
      print(e);
      time = 'Failed to Load! ';
    }

  }
}
