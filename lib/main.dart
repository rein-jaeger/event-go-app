import 'package:event_go_app/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  Paint.enableDithering = true;
  runApp(const EventGoApp());
}

class EventGoApp extends StatelessWidget {
  const EventGoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventGO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}