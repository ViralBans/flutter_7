import 'package:flutter/material.dart';

class DetailArtist extends StatelessWidget {
  static const routeName = '/detail_artist';
  final String link, about;

  const DetailArtist({Key? key, required this.link, required this.about}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{'link': '', 'about': ''}) as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(link),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: Text(about)),
      ),
    );
  }
}
