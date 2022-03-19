import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:receipe/screens/check.dart';
import 'package:receipe/screens/introscreen.dart';
import 'package:receipe/screens/main_screen.dart';

void main() {
  runApp(ProviderScope(child: myreceipe()));
}

class myreceipe extends StatelessWidget {
  const myreceipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: intro_screen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
