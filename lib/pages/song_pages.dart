import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/provider_song.dart';
import 'package:music_player/models/song.dart';
import 'package:provider/provider.dart';

class SongPages extends StatelessWidget {
  const SongPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSong>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),

                    Text("PL A Y L I S T"),

                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),

                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: Image.asset("assets/images/ephi.jpg"),
                      ),

                      const Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "I wish I was your joke",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text("Reality Club"),
                              ],
                            ),

                            Icon(Icons.favorite, color: Colors.green),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("0:00"),
                          Icon(Icons.shuffle),
                          Icon(Icons.repeat),
                          Text("0:00"),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: 
                          const RoundSliderThumbShape(enabledThumbRadius: 0),
                      ),
                      child: Slider(
                        min: 0,
                        max: 100,
                        value: 50,
                        activeColor: Colors.yellow,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
