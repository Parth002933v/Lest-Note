//to use this number verification we have to add SHA1 and SHA256 fingerprint key
//in FireBase Project Setting on website
//For That to find key type in cmd
//
// cd android
// .\gradlew signingReport

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'screen/HomeScreen.dart';

late Size mq;

_initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialiseFirebase App
  await _initialiseFirebase();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Note',

      // Ligth Theme
      theme: ThemeData(
        useMaterial3: true,
      ),

      // Dark theme
      darkTheme: ThemeData.dark(useMaterial3: true),

      // Theme Mode
      themeMode: ThemeMode.system,
      home: HzomeScreen(),
    );
  }
}
