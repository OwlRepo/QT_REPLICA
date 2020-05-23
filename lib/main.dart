import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';
import 'package:quicktalk_replica/Pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/PreLoadFlare.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';

void main() {
  FlareCache.doesPrune = false;
  PreLoadFlare();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WidgetHelper()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
