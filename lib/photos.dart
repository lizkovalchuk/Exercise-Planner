import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Photos extends StatefulWidget {
  final String exerciseId;

  Photos({Key key, @required this.exerciseId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExecisesState();
}

class _ExecisesState extends State<Photos> {
  var exerciseList = List<Widget>();

  @override
  Widget build(BuildContext context) {
    _getPhotos();

    return Scaffold(
        appBar: AppBar(title: Text('Photos')),
        body: exerciseList.length == 0
            ? Container()
            : CarouselSlider(height: 500, items: exerciseList));
  }

  _getPhotos() async {
    var list = List<Widget>();
    var mg = await Firestore.instance
        .collection("photos")
        .where('exercise_id', isEqualTo: widget.exerciseId)
        .orderBy('order')
        .getDocuments();
    mg.documents.forEach((e) {
      print(e);
      // list.add(ListTile(title: Text(e.data["name"])));
      list.add(Column(
        children: <Widget>[
          Image.network("${e.data["url"]}"),
          Text("${e.data["order"]} of ${mg.documents.length}")
        ],
      ));
    });

    setState(() {
      exerciseList = list;
    });
  }
}
