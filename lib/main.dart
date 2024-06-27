import 'package:flutter/material.dart';
import 'package:myapp/homePage.dart';
import 'package:myapp/loginPage.dart';
import 'package:myapp/registrationPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1944089679.
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
        debugShowCheckedModeBanner: false,
        home: Loginpage());
  }
}

