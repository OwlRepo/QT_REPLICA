import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quicktalk_replica/Pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/PreLoadFlare.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';
import 'dart:async';
void main() {

   WidgetsFlutterBinding.ensureInitialized();   
  FlareCache.doesPrune = false;
  PreLoadFlare();
    requestPermissions();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WidgetHelper()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> requestPermissions() async{
  Map<Permission, PermissionStatus> statuses = await [
  Permission.location,
  Permission.storage,
].request();

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
