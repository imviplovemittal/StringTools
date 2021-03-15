import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:stringtools/homepage.dart';

import 'collate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String tools',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/collate': (context) => CollatePage()
      },
    );
  }
}