import 'package:flutter/material.dart';

class DetailArtist extends StatelessWidget {
  const DetailArtist({Key? key, required this.link, required this.about}) : super(key: key);

  final String link, about;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(link),
      ),
      body: SafeArea(
        child: Text(about),
      ),
    );
  }
}
