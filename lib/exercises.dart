import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_hello/bucket_model.dart';
import 'package:flutter_app_hello/photos.dart';

class Exercises extends StatefulWidget {
  final String mgId;

  Exercises({Key key, @required this.mgId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExecisesState();
}

class _ExecisesState extends State<Exercises> {
  var exerciseList = List<Widget>();

  @override
  Widget build(BuildContext context) {
    _getExercises();

    return Scaffold(
        appBar: AppBar(title: Text('Exercises')),
        body: ListView(children: exerciseList));
  }

  _getExercises() async {
    var list = List<Widget>();
    var mg = await Firestore.instance
        .collection("exercises")
        .where('muscle-group-id', isEqualTo: widget.mgId)
        .getDocuments();
    mg.documents.forEach((e) {
      list.add(ListTile(
          title: Text(e.data["name"]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Photos(exerciseId: e.documentID)),
            );
          },
          trailing: IconButton(
              onPressed: () =>
                  _addToBucket(e.documentID, e.data["name"], context),
              icon: Icon(Icons.add))));
    });

    setState(() {
      exerciseList = list;
    });
  }

  _addToBucket(String documentID, String exerciseName, BuildContext context) {
    print("id: $documentID | exerciseName: $exerciseName");
    Firestore.instance
        .collection("bucket")
        .where('exercise_id', isEqualTo: documentID)
        .getDocuments()
        .then((e) {
      e.documents.forEach((DocumentSnapshot f) {
        f.reference.delete();
      });

      Firestore.instance
          .collection("bucket")
          .add(BucketModel(documentID, exerciseName).toJson())
          .then((e) {
        // Scaffold.of(context).showSnackBar(
        //     SnackBar(content: Text("Added $exerciseName to Bucket")));
      }).catchError((e) {
        // Scaffold.of(context).showSnackBar(
        //     SnackBar(content: Text("Error adding $exerciseName to Bucket")));
      });
    });
  }
}
