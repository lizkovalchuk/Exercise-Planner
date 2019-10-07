import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UpNext extends StatefulWidget {
  @override
  _UpNextState createState() => _UpNextState();
}

class _UpNextState extends State<UpNext> {
  var groups = List<Widget>();

  @override
  Widget build(BuildContext context) {
    _getUpNext();
    return Scaffold(
      appBar: AppBar(title: Text('Muscle Groups')),
//      body: Center(child: Text('You\'ve worked out ${daysWorkedout} this year' , textScaleFactor: 2,)),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(color: Theme.of(context).bottomAppBarColor,
              child: CarouselSlider(height: 400, items: groups)),
          Center(child: Text("body"))
        ],
      )),
    );
  }

  _getUpNext() async {
    var list = List<Widget>();
    var mg =
        await Firestore.instance.collection("muscle-groups").getDocuments();
    mg.documents.forEach((e) {
      list.add(Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("${e.data["name"]}"),
      )));
    });
    setState(() {
      groups = list;
    });
  }
}
