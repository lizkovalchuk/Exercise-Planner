import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_hello/bucket.dart';
import 'package:flutter_app_hello/muscle-groups.dart';

class MainHomePage extends StatefulWidget {
  final String title;

  MainHomePage({Key key, this.title}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var daysWorkedout;
  var userId;

  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection("total-days").getDocuments().then((td) {
      daysWorkedout = td.documents.first.data["count"];
    });
    FirebaseAuth.instance.signInAnonymously().then((e) {
      // print(e.user.uid);

      setState(() {
        userId = e.user.uid;
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
//      body: Center(child: Text('You\'ve worked out ${daysWorkedout} this year' , textScaleFactor: 2,)),
      body: Center(
          child: Column(
        children: <Widget>[
          // change this Text to image
          Text(
            'You\'ve worked out ${daysWorkedout} this year',
            textScaleFactor: 2,
          ),

          // Text('Your user id is ${userId}' , textScaleFactor: 2,),
        ],
      )),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Muscle Group'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MuscleGroup()),
                  );
                },
              ),
            ),
            ListTile(
              title: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Bucket'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bucket()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
