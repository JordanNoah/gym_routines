import 'package:flutter/material.dart';
import 'dart:developer';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _Main createState() => _Main();
}

class _Main extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Gym routines'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => log('data: a'),
              icon: const Icon(Icons.supervised_user_circle_outlined),
              focusColor: Colors.transparent)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed("/machines"),
                child: const Text("Machines")),
            TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed("/start_routine"),
                child: const Text("Start routine")),
          ],
        ),
      ),
    ));
  }
}
