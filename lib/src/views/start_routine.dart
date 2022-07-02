import 'package:flutter/material.dart';
import 'dart:developer';

class StartRoutine extends StatefulWidget {
  const StartRoutine({Key? key}) : super(key: key);

  @override
  _StartRoutineState createState() => _StartRoutineState();
}

class _StartRoutineState extends State<StartRoutine> {
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
          children: const <Widget>[Text('data'), Text("data")],
        ),
      ),
    ));
  }
}
