import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home_manager/util/colors.dart';
import 'package:smart_home_manager/util/electricity_usage_data.dart';
import 'package:smart_home_manager/util/music_sources.dart';
import 'package:smart_home_manager/view/home/widget/frostGlassBox.dart';
import 'package:smart_home_manager/view/home/widget/stats_bar.dart';
import 'package:smart_home_manager/view/temperature/temperature.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool temperature = false;
  bool plugWall = false;
  bool smartTV = false;

  PageController pageController = PageController();
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool? isPlaying;
  bool? isBuffering;

  Future<void> loadMusic(index) async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(songs[index].musicUrl,
            metas: Metas(
                id: index.toString(),
                title: songs[index].title,
                artist: songs[index].artist,
                image: MetasImage(
                    path: songs[index].imageUrl!,
                    type: songs[index].networkBased == true
                        ? ImageType.network
                        : ImageType.asset))),
      );
      await assetsAudioPlayer.pause();
      assetsAudioPlayer.isBuffering.listen((event) {
        print(event);
        setState(() {
          isBuffering = event;
        });
      });
      assetsAudioPlayer.isPlaying.listen((event) {
        setState(() {
          isPlaying = event;
        });
      });
    } catch (t) {
      //mp3 unreachable
    }
  }

  @override
  void initState() {
    super.initState();
    loadMusic(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              color: Colors.brown,
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(131, 117, 108, 0.7), BlendMode.dstATop),
              )),
          child: SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Good Morning",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                              )),
                          Text("Chris Cooper",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      const FrostGlassBox(
                        childWidth: 50.0,
                        childHeight: 50.0,
                        childWidget: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text("Living Room",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FrostGlassBox(
                        childWidth: 160,
                        childHeight: 220,
                        childSelected: temperature,
                        navigationWidget: Temperature(
                          title: "Living Room",
                          description: "Home Temperature",
                          switchStatus: temperature,
                          updateSwitch: (val) {
                            setState(() {
                              temperature = val;
                            });
                          },
                        ),
                        parentContext: context,
                        childWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Home\nTemperature",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: temperature == true
                                        ? Colors.black
                                        : Colors.white)),
                            Row(
                              children: [
                                Text("23",
                                    style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w600,
                                        color: temperature == true
                                            ? Colors.black
                                            : Colors.white)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("°C",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: temperature == true
                                            ? Colors.black
                                            : Colors.white)),
                              ],
                            ),
                            CupertinoSwitch(
                                activeColor: ColorPalette.orange,
                                trackColor: ColorPalette.grey,
                                value: temperature,
                                onChanged: (v) {
                                  setState(() {
                                    temperature = !temperature;
                                  });
                                })
                          ],
                        ),
                      ),
                      FrostGlassBox(
                        childWidth: 160,
                        childHeight: 220,
                        childSelected: plugWall,
                        childWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Plug Wall",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: plugWall == true
                                            ? Colors.black
                                            : Colors.white)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: plugWall == true
                                      ? Colors.black
                                      : Colors.white,
                                  size: 18,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("●   Macbook Pro",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: plugWall == true
                                            ? Colors.black
                                            : Colors.white)),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("●   HomePod",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: ColorPalette.grey)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("●   PlayStattion 5",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: plugWall == true
                                            ? Colors.black
                                            : Colors.white)),
                              ],
                            ),
                            CupertinoSwitch(
                                activeColor: ColorPalette.orange,
                                trackColor: ColorPalette.grey,
                                value: plugWall,
                                onChanged: (v) {
                                  setState(() {
                                    plugWall = !plugWall;
                                  });
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FrostGlassBox(
                          childWidth: 160,
                          childHeight: 140,
                          childWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: double.maxFinite,
                                  height: 40,
                                  child: PageView.builder(
                                    controller: pageController,
                                    onPageChanged: (index) {
                                      loadMusic(index);
                                    },
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: songs.length,
                                    itemBuilder: (context, index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 40,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      songs[index].imageUrl!),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                songs[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                songs[index].artist,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                    visualDensity: VisualDensity.compact,
                                    icon: const FaIcon(
                                      FontAwesomeIcons.stepBackward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isBuffering == false
                                          ? assetsAudioPlayer.playOrPause()
                                          : null;
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          color: Colors.white24),
                                      child: isBuffering == true
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.0,
                                            )
                                          : FaIcon(
                                              isPlaying == true
                                                  ? FontAwesomeIcons.pause
                                                  : FontAwesomeIcons.play,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                    visualDensity: VisualDensity.compact,
                                    icon: const FaIcon(
                                      FontAwesomeIcons.stepForward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                      FrostGlassBox(
                          childWidth: 160,
                          childHeight: 140,
                          childSelected: smartTV,
                          childWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Smart TV",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: smartTV == true
                                                  ? Colors.black
                                                  : Colors.white)),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: smartTV == true
                                            ? Colors.black
                                            : Colors.white,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("Samsung UA55 4AC",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: smartTV == true
                                              ? Colors.black
                                              : Colors.white)),
                                ],
                              ),
                              CupertinoSwitch(
                                  activeColor: ColorPalette.orange,
                                  trackColor: ColorPalette.grey,
                                  value: smartTV,
                                  onChanged: (v) {
                                    setState(() {
                                      smartTV = !smartTV;
                                    });
                                  })
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Statistics",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      Text("Month",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.white60)),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FrostGlassBox(
                      childWidth: 350,
                      childHeight: 200,
                      childWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Electricity Usage",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 18,
                              )
                            ],
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (int i = 0;
                                    i < electricityStats.height.length;
                                    i++)
                                  StatsBar(
                                      height: electricityStats.height[i],
                                      position: electricityStats.position[i],
                                      increment: electricityStats.increment[i])
                              ])
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
