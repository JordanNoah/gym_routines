import 'package:flutter/material.dart';
import 'package:gym_routines/db/machines_database.dart';
import 'package:gym_routines/model/machine.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:developer';

class Machines extends StatefulWidget {
  const Machines({Key? key}) : super(key: key);

  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  late List<Machine> response;
  late Machine machine;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    response = await MachinesDatabase.instance.readAllMachines();
    log(response.toString());
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
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
                Navigator.pushNamed(context, '/machine_action');
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
              itemBuilder: (c, i) =>
                  Card(elevation: 0, child: Center(child: Text(items[i]))),
              itemExtent: 100.0,
              itemCount: items.length,
            ),
          ))
        ],
      ),
    ));
  }
}
