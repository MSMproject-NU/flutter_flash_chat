import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/Pages/home.dart';

import 'Pages/login.dart';


void main() => runApp(Flash_Chat());

class Flash_Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flash_Chat",
      home: Home(),
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,

        accentColor: Colors.black45,

      ),

    );
  }
}
