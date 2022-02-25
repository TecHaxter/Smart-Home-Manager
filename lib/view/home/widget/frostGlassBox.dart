import 'dart:ui';
import 'package:flutter/material.dart';

class FrostGlassBox extends StatelessWidget {
  final double childWidth;
  final double childHeight;
  final Widget childWidget;
  final bool? childSelected;
  final Widget? navigationWidget;
  final BuildContext? parentContext;
  const FrostGlassBox(
      {Key? key,
      required this.childWidth,
      required this.childHeight,
      required this.childWidget,
      this.childSelected = false,
      this.navigationWidget,
      this.parentContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationWidget != null
            ? showModalBottomSheet(
                context: parentContext!,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => navigationWidget!,
              )
            : null;
      },
      child: DecoratedBox(
        // width: 200,
        // height: 200,
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10.withAlpha(80)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 1,
            ),
            BoxShadow(
              spreadRadius: 1,
              color: Colors.white.withOpacity(0.2),
              offset: const Offset(-1, -1),
              blurRadius: 1,
            )
          ],
        ),
        child: Container(
          width: childWidth,
          height: childHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Container(
                color:
                    childSelected == true ? Colors.white : Colors.transparent,
                padding: EdgeInsets.symmetric(
                    horizontal: childWidth / 10, vertical: childWidth / 10),
                child: childWidget),
          ),
        ),
      ),
    );
  }
}
