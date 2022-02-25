import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home_manager/util/colors.dart';
import 'package:smart_home_manager/view/temperature/widget/grey_box.dart';
import 'package:smart_home_manager/view/temperature/widget/temp_dial.dart';

class Temperature extends StatefulWidget {
  final bool switchStatus;
  final Function? updateSwitch;
  final String title;
  final String description;
  const Temperature(
      {Key? key,
      required this.switchStatus,
      this.updateSwitch,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  bool switchStatus = false;

  int? selectedMode;
  int? selectedOption;

  @override
  void initState() {
    super.initState();
    switchStatus = widget.switchStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 680,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
          color: switchStatus == true ? Colors.white : ColorPalette.grey,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              color: Colors.black26,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                    Text(
                      widget.description,
                    ),
                  ],
                ),
                CupertinoSwitch(
                    value: switchStatus,
                    activeColor: ColorPalette.orange,
                    onChanged: (val) {
                      setState(() {
                        switchStatus = !switchStatus;
                      });
                      widget.updateSwitch!(switchStatus);
                    })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const TempDial(),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Current temp",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      fontSize: 16),
                ),
                Text(
                  "Current humidity",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.black45,
                    ),
                    Text(
                      "24",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    Text(
                      "°C",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    Text(
                      "54",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    Text(
                      "%",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedMode = selectedMode == 1 ? null : 1;
                    });
                  },
                  child: GreyBox(
                      selected: selectedMode == 1,
                      width: 110,
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Text(
                                "Heating  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Icon(
                                Icons.circle,
                                color: ColorPalette.orange,
                                size: 10,
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "24",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 28),
                              ),
                              Text(
                                " °C",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedMode = selectedMode == 2 ? null : 2;
                    });
                  },
                  child: GreyBox(
                      selected: selectedMode == 2,
                      width: 110,
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Text(
                                "Cooling  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.blue,
                                size: 10,
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "18",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 28),
                              ),
                              Text(
                                " °C",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedMode = selectedMode == 3 ? null : 3;
                    });
                  },
                  child: GreyBox(
                      selected: selectedMode == 3,
                      width: 110,
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Text(
                                "Airwave  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "20",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 28),
                              ),
                              Text(
                                " °C",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedOption = selectedOption == 1 ? null : 1;
                    });
                  },
                  child: GreyBox(
                      selected: selectedOption == 1,
                      width: 170,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Fan",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                selectedOption == 1 ? "On" : "Off",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                            ],
                          ),
                          const FaIcon(
                            FontAwesomeIcons.fan,
                            size: 28,
                            color: Colors.black12,
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedOption = selectedOption == 2 ? null : 2;
                    });
                  },
                  child: GreyBox(
                      selected: selectedOption == 2,
                      width: 170,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Cooler",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                selectedOption == 2 ? "On" : "Off",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                            ],
                          ),
                          const FaIcon(
                            FontAwesomeIcons.snowflake,
                            size: 28,
                            color: Colors.black12,
                          )
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
