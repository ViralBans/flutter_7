import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_7/screens/albums_screen.dart';
import 'package:flutter_7/screens/detail_artist_screen.dart';
import 'package:flutter_7/screens/error_screen.dart';
import 'package:flutter_7/screens/home_screen.dart';

class RouterFluro {
  static FluroRouter router = FluroRouter();

  static final _homeHandler = Handler(handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return const HomeScreen();
  }));

  static final _albumHandler = Handler(handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return const AlbumScreen();
  }));

  static final _detailHandler = Handler(handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return DetailArtist(link: params['link'][0], about: params['about'][0]);
  }));

  static initRoutes() {
    router.define("/", handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define("album/", handler: _albumHandler, transitionType: TransitionType.fadeIn);
    router.define("detail/:link/:about", handler: _detailHandler, transitionType: TransitionType.fadeIn);
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
          return const ErrorScreen();
        });
  }
}