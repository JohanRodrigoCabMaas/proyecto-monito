import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('contacts');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: FirebaseAnimatedList(
          query: dbRef,
          shrinkWrap: true,
          itemBuilder: (context, snapshot, animation, index) {
            if (snapshot.value != null) {
              Map contact = snapshot.value as Map;
              contact['key'] = snapshot.key;

              return Text(contact['name']);
            } else {
              return const Center(
                child: Text('No hay citas'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            dbRef.push().set({
              "name": "John",
              "age": 18,
              "address": {"line1": "100 Mountain View"}
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}
