import 'package:flutter/material.dart';
import 'package:gym_routines/db/machines_database.dart';
import 'package:gym_routines/model/machine.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class Machines extends StatefulWidget {
  const Machines({Key? key}) : super(key: key);

  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  late List<Machine> items = [];
  late Machine machine;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    items = await MachinesDatabase.instance.readAllMachines();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    if (mounted) setState(() {});
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.00,
        title: const Text('Machines and exercises'),
      ),
      body: Column(
        children: [
          OutlinedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("/machine_action", arguments: null);
              },
              child: const Text("New machine")),
          Expanded(
              child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, int index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actions: [
                      IconSlideAction(
                        caption: 'Remove',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => removeMachine(index),
                      ),
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.blue,
                        icon: Icons.edit,
                        onTap: () => editMachine(context, index),
                      )
                    ],
                    child: ListTile(
                      leading: Icon(Icons.message),
                      title: Text("${items[index].name}"),
                      subtitle: Text("${items[index].type}"),
                      trailing: Icon(Icons.arrow_back),
                    ),
                  );
                }),
          ))
        ],
      ),
    ));
  }

  removeMachine(index) async {
    var response = await MachinesDatabase.instance.delete(items[index].id);
    setState(() {
      items.removeAt(index);
    });
  }

  editMachine(context, index) {
    Navigator.of(context)
        .pushNamed("/machine_action", arguments: items[index].id);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
