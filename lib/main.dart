import 'package:field_notes/base_camp/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:load_toast/load_toast.dart';

void main() {
  runApp(LoadToast(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Field Notes';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(

        primarySwatch: Colors.purple,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(appTitle: appTitle),
    );
  }
}


