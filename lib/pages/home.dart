import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // print(data);
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // print(data);
    String bgImage = data['isDay'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDay'] ? Colors.white : Colors.blue.shade900;
    Color textColor = data['isDay'] ? Colors.white : Colors.yellow.shade600;

    // print(bgImage);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 0.0, 0.0),
            child: Column(children: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  // print(result);
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDay': result['isDay'],
                      'flag': result['flag'],
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.white,
                ),
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 50.0,
                      letterSpacing: 2.0,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: 50.0),
              Text(
                data['time'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
