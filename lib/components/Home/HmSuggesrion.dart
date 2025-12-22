import 'package:flutter/material.dart';

class Hmsuggesrion extends StatefulWidget {
  const Hmsuggesrion({super.key});

  @override
  State<Hmsuggesrion> createState() => _HmsuggesrionState();
}

class _HmsuggesrionState extends State<Hmsuggesrion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text('搜索建议', style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}