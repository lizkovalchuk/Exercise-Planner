

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class MuscleGroups extends StatefulWidget {
  @override
  _MuscleGroupsState createState() => _MuscleGroupsState();
}

class _MuscleGroupsState extends State<MuscleGroups> {
  var groups = List<Widget>();

  @override
  Widget build(BuildContext context) {
    _getMuscleGroups();
    return Scaffold(
      appBar: AppBar(
          title: Text('Muscle Groups')
      ),
//      body: Center(child: Text('You\'ve worked out ${daysWorkedout} this year' , textScaleFactor: 2,)),
      body: Center(child: Column(
        children: groups,
      )),
    );
  }

  _getMuscleGroups() async {
    var list = List<Widget>();
    var mg = await Firestore.instance.collection("muscle-groups").getDocuments();
    mg.documents.forEach((e) {
      list.add(Text("${e.data["name"]}"));


    });
    setState(() {
      groups = list;
    });
  }
}