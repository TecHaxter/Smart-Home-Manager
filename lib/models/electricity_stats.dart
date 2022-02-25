import 'package:flutter/cupertino.dart';

class ElectricityStats {
  final List<double> height;
  final List<double> position;
  final List<bool> increment;
  const ElectricityStats({
    Key? key,
    required this.height,
    required this.position,
    required this.increment,
  });
}
