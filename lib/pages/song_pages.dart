import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/provider_song.dart';
import 'package:music_player/models/song.dart';
import 'package:provider/provider.dart';

class SongPages extends StatelessWidget {
  const SongPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSong>(builder: (context,value,child) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25), 
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_back)),
          
                  Text("PL A Y L I S T"),
          
                IconButton(
                  onPressed: () {}, icon: Icon(Icons.menu)),
                ],
              ),

              NeuBox(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.asset("assets/images/ephi.jpg")))
            ],
              ),
        ),
      ),
    ),
  );
  }
}