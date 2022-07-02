import 'package:flutter/material.dart';

class MachineAction extends StatefulWidget {
  const MachineAction({Key? key}) : super(key: key);

  @override
  _MachineAction createState() => _MachineAction();
}

class _MachineAction extends State<MachineAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine action'),
        elevation: 0.00,
      ),
      body: const Text("data"),
    );
  }
}
