import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system_app/view/screens/home_page.dart';
import 'package:solar_system_app/view/screens/splash.dart';

import 'controller/home_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeController(),
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
