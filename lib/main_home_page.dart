import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_hello/muscle_groups.dart';
import 'package:flutter_app_hello/up_next.dart';



class MainHomePage extends StatefulWidget{
  final String title;

  MainHomePage({ Key key, this.title}) : super(key:key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var daysWorkedout = 35;
  var userId;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signInAnonymously().then((e) {
      print(e.user.uid);

      setState(() {
        userId = e.user.uid;
      });
    });

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title)
      ),
//      body: Center(child: Text('You\'ve worked out ${daysWorkedout} this year' , textScaleFactor: 2,)),
      body: Center(child: Column(
        children: <Widget>[
          Text('You\'ve worked out ${daysWorkedout} this year' , textScaleFactor: 2,),
          Text('Your user id is ${userId}' , textScaleFactor: 2,),
        ],
      )),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: InkWell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Up Next'),
              ), onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpNext()),
                );
              },),
            ),
            ListTile(
              title: InkWell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Muscle Groups'),
              ), onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MuscleGroups()),
                );
              },),
            ),
            ListTile(
              title: Text('Design Workout'),
            ),
            ListTile(
              title: Text('Add Stats'),
            ),
          ],
        ),
      ),
    );
  }
}

