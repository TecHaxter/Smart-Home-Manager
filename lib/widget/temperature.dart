import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';

class Temperature extends StatefulWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  double _angle = 0.0;
  double _oldAngle = 0.0;
  double _angleDelta = 0.0;

  final leftLimit = -1.54;
  final rightLimit = 1.54;

  int temperature = 22;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  // color: Colors.pink,
                  width: double.maxFinite,
                  height: 280,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: const TextSpan(
                                    text: "14",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black54),
                                    children: [
                                  TextSpan(
                                    text: " °C",
                                    style: TextStyle(fontSize: 14.0),
                                  )
                                ])),
                            RichText(
                                text: const TextSpan(
                                    text: "28",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black54),
                                    children: [
                                  TextSpan(
                                    text: " °C",
                                    style: TextStyle(fontSize: 14.0),
                                  )
                                ])),
                          ],
                        ),
                      ),
                      CircularText(
                        children: [
                          TextItem(
                            text: const Text(
                              "| | | | | | | | | | | | | | | | | | | | |",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            space: 4,
                            startAngle: -90,
                            startAngleAlignment: StartAngleAlignment.center,
                            direction: CircularTextDirection.clockwise,
                          ),
                        ],
                        radius: 140,
                        position: CircularTextPosition.inside,
                        // backgroundPaint: Paint()..color = Colors.grey.shade200,
                      ),
                      Positioned(
                        child: Transform.rotate(
                          angle: _angle,
                          child: Stack(
                            children: [
                              Container(
                                height: 220,
                                width: 220,
                                margin: const EdgeInsets.all(32.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(110),
                                    color: const Color(0xFFFDFDFD),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 20)
                                    ]),
                              ),
                              Positioned(
                                top: 10.0,
                                left: 0.0,
                                right: 0.0,
                                child: SizedBox(
                                  width: 30,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      //   Offset centerOfGestureDetector = Offset(
                                      // constraints.maxWidth / 2, constraints.maxHeight / 2);
                                      /**
                                               * using center of positioned element instead to better fit the
                                               * mental map of the user rotating object.
                                               * (height = container height (30) + container height (30) + container height (200)) / 2
                                               */
                                      Offset centerOfGestureDetector =
                                          Offset(constraints.maxWidth / 2, 130);
                                      return GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onPanStart: (details) {
                                            final touchPositionFromCenter =
                                                details.localPosition -
                                                    centerOfGestureDetector;
                                            if (_angle > leftLimit &&
                                                _angle < rightLimit) {
                                              _angleDelta = _oldAngle -
                                                  touchPositionFromCenter
                                                      .direction;
                                            }
                                          },
                                          onPanEnd: (details) {
                                            setState(
                                              () {
                                                _oldAngle = _angle;
                                              },
                                            );
                                          },
                                          onPanUpdate: (details) {
                                            final touchPositionFromCenter =
                                                details.localPosition -
                                                    centerOfGestureDetector;
                                            setState(
                                              () {
                                                _angle = (touchPositionFromCenter
                                                                    .direction +
                                                                _angleDelta >
                                                            leftLimit &&
                                                        touchPositionFromCenter
                                                                    .direction +
                                                                _angleDelta <
                                                            rightLimit)
                                                    ? touchPositionFromCenter
                                                            .direction +
                                                        _angleDelta
                                                    : _angle;

                                                double curr =
                                                    leftLimit - _angle;
                                                temperature =
                                                    ((curr.abs() / 0.22) + 14)
                                                        .round();
                                              },
                                            );
                                          },
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            direction: Axis.vertical,
                                            runAlignment: WrapAlignment.center,
                                            spacing: -10,
                                            // mainAxisAlignment: MainAxisAlignment.,
                                            children: const [
                                              Icon(
                                                Icons.arrow_drop_up,
                                                size: 42,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                size: 6,
                                              ),
                                            ],
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 20)
                              ]),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                  text: temperature.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 44,
                                      fontWeight: FontWeight.w500),
                                  children: const [
                                    TextSpan(
                                        text: " °C",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400))
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
