import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;

  String? _idCreated;

  void _createData() {
    final user = <String, dynamic>{
      "first": "Alan",
      "last": "Turing",
      "born": 1912
    };

    db.collection("users").add(user).then(
          (doc) {
            print('DocumentSnapshot added with ID: ${doc.id}');
            _idCreated = doc.id;
          },
          onError: (e) => print("Error adding document $e"),
        );
  }

  void _readAllData() {
    if (_idCreated != null) {
      db.collection("users").get().then(
        (querySnapshot) {
          print("Successfully get collection");
          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    }
  }

  void _updateData() {
    if (_idCreated != null) {
      db.collection("users").doc(_idCreated).update({"last": "Wake"}).then(
        (_) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"),
      );
    }
  }

  void _deleteData() {
    if (_idCreated != null) {
      db.collection("users").doc(_idCreated).delete().then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error deleting document $e"),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _createData,
                child: const Text('Create'),
              ),
              ElevatedButton(
                onPressed: _readAllData,
                child: const Text('Read'),
              ),
              ElevatedButton(
                onPressed: _updateData,
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: _deleteData,
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
