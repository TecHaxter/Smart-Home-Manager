import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:smart_home_manager/view/home/home.dart';
import 'package:smart_home_manager/view/temperature/temperature.dart';
=======
import 'package:smart_home_manager/view/home.dart';
>>>>>>> parent of 4df45e5 (0.2)

void main() {
  runApp(const SmartHomeManager());
}

class SmartHomeManager extends StatelessWidget {
  const SmartHomeManager({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Manager',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pulp Display'),
      home: const Home(),
    );
  }
}
