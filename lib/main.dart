// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutterfirebaselogin/login.dart';
import 'package:flutterfirebaselogin/interna.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, 
    home: Login(),
    ),
  );
}
