import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsBar extends StatelessWidget {
  final double height;
  final bool increment;
  final double position;
  const StatsBar(
      {Key? key,
      required this.height,
      required this.increment,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: height,
      margin: EdgeInsets.only(top: position),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: increment == true ? Colors.white : Colors.white30,
      ),
    );
  }
}
