import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_app_hello/exercises.dart';

class MuscleGroup extends StatefulWidget {
  @override
  _MuscleGroupState createState() => _MuscleGroupState();
}

class _MuscleGroupState extends State<MuscleGroup> {
  var groups = List<Widget>();

  @override
  Widget build(BuildContext context) {
    _getMuscleGroups();
    return Scaffold(
      appBar: AppBar(title: Text('Muscle Groups')),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
              //color: Theme.of(context).bottomAppBarColor,
              child: groups.length == 0
                  ? Container()
                  // : CarouselSlider(height: 400, items: groups)),
                  : CarouselSlider(height: 300, items: groups)),
        ],
      )),
    );
  }

  _getMuscleGroups() async {
    var list = List<Widget>();
    var mg =
        await Firestore.instance.collection("muscle-groups").getDocuments();
    mg.documents.forEach((e) {
      list.add(InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Exercises(mgId: e.documentID)),
          );
        },
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${e.data["name"]}",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Image.network("${e.data["imageUrl"]}"),
                  ],
                ))),
      ));
    });
    setState(() {
      groups = list;
    });
  }
}
