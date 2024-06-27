import 'package:flutter/material.dart';

class Profilpage extends StatelessWidget {
  const Profilpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
            child: Column(
          children: [
            Text('Profil'),
            ElevatedButton(onPressed: () {}, child: Text('Kembali'))
          ],
        )));
  }
}
