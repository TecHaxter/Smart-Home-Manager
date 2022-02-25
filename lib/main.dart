import 'package:flutter/material.dart';
import 'package:smart_home_manager/view/home.dart';
import 'package:smart_home_manager/widget/temperature.dart';

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
      home: const Temperature(),
    );
  }
}
