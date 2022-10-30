import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen>
    with AutomaticKeepAliveClientMixin {
  Future<List> _loadData() async {
    List posts = [];
    final String response = await rootBundle.loadString('assets/artists.json');
    posts = await json.decode(response);
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: _loadData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, index) => Card(
                      child: ListTile(
                        title: Text(snapshot.data![index]['name']),
                        onTap: () {
                          Navigator.pushNamed(context, '/detail_artist', arguments: {
                            'link': snapshot.data![index]['link'],
                            'about': snapshot.data![index]['about']
                          });
                        },
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
