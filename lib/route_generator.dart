import 'package:flutter/material.dart';
import 'package:gym_routines/src/views/main.dart';
import 'package:gym_routines/src/views/start_routine.dart';
import 'package:gym_routines/src/views/machines.dart';
import 'package:gym_routines/src/views/machine_action.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Main());
      case '/start_routine':
        return MaterialPageRoute(builder: (_) => const StartRoutine());
      case '/machines':
        return MaterialPageRoute(builder: (_) => const Machines());
      case '/machine_action':
        return MaterialPageRoute(builder: (_) => const MachineAction());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text("NO EXISTE RUTA"),
        ),
      );
    });
  }
}
