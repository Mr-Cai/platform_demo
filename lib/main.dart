import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter_svg/svg.dart';

Widget svg(String txt) => SvgPicture.asset('asset/svg/$txt.svg');

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  String logoAsset = '';
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      logoAsset = 'android';
    } else if (Platform.isIOS) {
      logoAsset = 'apple';
    } else if (Platform.isWindows) {
      logoAsset = 'windows';
    } else if (Platform.isMacOS) {
      logoAsset = 'finder';
    } else if (Platform.isLinux) {
      logoAsset = 'linux';
    } else if (Platform.isFuchsia) {
      logoAsset = 'fuchisa';
    } else {
      logoAsset = 'chrome';
    }
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    ).drive(Tween(begin: 0, end: 2));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller
          ..reset()
          ..forward();
      },
      child: RotationTransition(
        turns: animation,
        child: Center(
          child: svg(logoAsset),
        ),
      ),
    );
  }
}
