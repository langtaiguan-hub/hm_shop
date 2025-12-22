import 'package:flutter/material.dart';

class Hmhot extends StatefulWidget {
  const Hmhot({super.key});

  @override
  State<Hmhot> createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text('热门商品', style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
