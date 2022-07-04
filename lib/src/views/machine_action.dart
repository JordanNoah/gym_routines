import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gym_routines/db/machines_database.dart';
import 'package:gym_routines/model/machine.dart';
import 'package:gym_routines/src/views/machines.dart';

class MachineAction extends StatefulWidget {
  final id;
  const MachineAction({Key? key, this.id}) : super(key: key);

  @override
  _MachineAction createState() => _MachineAction(id);
}

class _MachineAction extends State<MachineAction> {
  var id;
  _MachineAction(this.id);
  final _formKey = GlobalKey<FormState>();
  TextEditingController excerciseMachineController = TextEditingController();

  List machines = ['Mancuerna', 'Maquina', 'Corporal'];

  int _machinesExercises = 0;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      if (id != null) {
        getMachineUpdate(id);
      }
    }
  }

  Future getMachineUpdate(int id) async {
    log("message");
    var machine = await MachinesDatabase.instance.readMachine(id);
    setState(() {
      id = id;
      excerciseMachineController.text = machine.name;
      _machinesExercises = machine.type;
    });
    log(machine.name);
  }

  Future saveMachineExcercise() async {
    try {
      if (_formKey.currentState!.validate()) {
        var machine = Machine.fromJson({
          'name': excerciseMachineController.text,
          'type': _machinesExercises
        });
        var responseCreation = await MachinesDatabase.instance.create(machine);
        log(responseCreation.toString());
        if (responseCreation.id != null) {
          Navigator.pushNamed(context, '/machines');
        }
      } else {
        log("object11111");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateMachineExcercise(BuildContext context, int _id) async {
    log(_id.toString());
    try {
      if (_formKey.currentState!.validate()) {
        var machine = Machine.fromJson({
          '_id': _id,
          'name': excerciseMachineController.text,
          'type': _machinesExercises
        });
        var responseUpdate = await MachinesDatabase.instance.update(machine);
        Navigator.pushNamed(context, '/machines');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine action'),
        elevation: 0.00,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: 0,
                            groupValue: _machinesExercises,
                            onChanged: (_) {
                              setState(() {
                                _machinesExercises = 0;
                              });
                            }),
                        Text(machines[0])
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 1,
                            groupValue: _machinesExercises,
                            onChanged: (_) {
                              setState(() {
                                _machinesExercises = 1;
                              });
                            }),
                        Text(machines[1])
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 2,
                            groupValue: _machinesExercises,
                            onChanged: (_) {
                              setState(() {
                                _machinesExercises = 2;
                              });
                            }),
                        Text(machines[2])
                      ],
                    )
                  ],
                ),
                TextFormField(
                  controller: excerciseMachineController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid excercise';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text("Name excercise or machine"),
                      border: OutlineInputBorder()),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (id != null) {
                          updateMachineExcercise(context, id);
                        } else {
                          saveMachineExcercise();
                        }
                      },
                      child: id == null
                          ? const Text("Save machine or excercise")
                          : const Text('Update machine or excercise')),
                )
              ],
            )),
      ),
    );
  }
}
