import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_app_hello/photos.dart';

class Bucket extends StatefulWidget {
  @override
  _BucketState createState() => _BucketState();
}

class _BucketState extends State<Bucket> {
  var groups = List<Widget>();

  @override
  Widget build(BuildContext context) {
    _getBucketItems();
    return Scaffold(
        appBar: AppBar(title: Text('Bucket')),
//      body: Center(child: Text('You\'ve worked out ${daysWorkedout} this year' , textScaleFactor: 2,)),
        // body: Center(child: Column(
        body: ListView(children: groups));
  }

  _getBucketItems() async {
    var list = List<Widget>();
    var mg = await Firestore.instance.collection("bucket").getDocuments();
    mg.documents.forEach((e) {
      // list.add(Text("${e.data["name"]}"));
      // list.add(FlatButton("${e.data["name"]}"));
      list.add(
          _buildBucketItem(e.data["exercise_id"], e.data["exercise_name"]));
    });
    setState(() {
      groups = list;
    });
  }

  _buildBucketItem(exerciseId, exerciseName) {
    return ListTile(
        title: Text(exerciseName),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Photos(exerciseId: exerciseId)),
          );
        },
        trailing: IconButton(
            onPressed: () =>
                _removeFromBucket(exerciseId, exerciseName, context),
            icon: Icon(Icons.remove_circle)));
  }

  _removeFromBucket(exerciseId, exerciseName, BuildContext context) {
    Firestore.instance
        .collection("bucket")
        .where('exercise_id', isEqualTo: exerciseId)
        .getDocuments()
        .then((e) {
      e.documents.forEach((DocumentSnapshot f) {
        f.reference.delete();
      });
    });
  }
}
