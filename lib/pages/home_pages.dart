import 'package:flutter/material.dart';
import 'package:music_player/components/drawer.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('P L A Y L I S T')),
      drawer: MyDrawer(),
    );
  }
}