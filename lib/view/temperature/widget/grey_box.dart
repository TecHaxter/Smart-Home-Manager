import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_manager/util/colors.dart';

class GreyBox extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final bool selected;
  const GreyBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.child,
      required this.selected})
      : super(key: key);

  @override
  State<GreyBox> createState() => _GreyBoxState();
}

class _GreyBoxState extends State<GreyBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
          color: widget.selected == false
              ? const Color(0xFFF5F5F6)
              : Colors.black12,
          borderRadius: BorderRadius.circular(24.0)),
      child: widget.child,
    );
  }
}
