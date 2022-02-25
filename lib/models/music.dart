import 'package:flutter/cupertino.dart';

class Music {
  final String title;
  final String artist;
  final String? album;
  final String musicUrl;
  final String? imageUrl;
  final bool? networkBased;

  const Music(
      {Key? key,
      required this.title,
      required this.artist,
      this.album,
      required this.musicUrl,
      required this.imageUrl,
      this.networkBased = true});
}
