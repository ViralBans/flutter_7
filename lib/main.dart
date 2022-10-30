import 'package:flutter/material.dart';
import 'package:flutter_7/screens/albums_screen.dart';
import 'package:flutter_7/screens/detail_artist_screen.dart';
import 'package:flutter_7/screens/error_screen.dart';
import 'package:flutter_7/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Title',
      ),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return const ErrorScreen();
        });
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case DetailArtist.routeName:
            return PageRouteBuilder(pageBuilder: (
              BuildContext context,
              Animation animation,
              Animation secondAnimation,
            ) {
              final args = settings.arguments as Map<String, dynamic>;
              if (args.containsKey('link') && args.containsKey('about')) {
                return DetailArtist(
                  link: args['link'],
                  about: args['about'],
                );
              } else {
                return const DetailArtist(
                  link: '',
                  about: '',
                );
              }
            }, transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondAnimation,
              child,
            ) {
              CurvedAnimation curved = CurvedAnimation(
                  parent: animation, curve: Curves.fastOutSlowIn);
              Animation<double> animate =
                  Tween(begin: 0.0, end: 1.0).animate(curved);
              return ScaleTransition(
                scale: animate,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            });
          default:
            return MaterialPageRoute(builder: (BuildContext context) {
              return const ErrorScreen();
            });
        }
      },
      // routes: {
      //   '/album': (context) => const AlbumScreen(),
      //   '/detail': (context) => const DetailArtist(),
      // },
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final drawerItems = [
    DrawerItem('Home', Icons.home),
    DrawerItem('Albums', Icons.album)
  ];

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomeScreen();
      case 1:
        return const AlbumScreen();
      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return WillPopScope(
      onWillPop: () async {
        if (_selectedDrawerIndex != 0) {
          setState(() {
            _selectedDrawerIndex = 0;
          });
          _getDrawerItemWidget(_selectedDrawerIndex);
        } else {
          Navigator.pop(context, true);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.drawerItems[_selectedDrawerIndex].title),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountEmail: Text('email@gmail.com'),
                accountName: Text('Username'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://publicdomainvectors.org/photos/Male-Avatar-2.png'),
                ),
              ),
              Column(children: drawerOptions)
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }
}
