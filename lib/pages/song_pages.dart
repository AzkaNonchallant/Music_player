import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/provider_song.dart';
import 'package:music_player/models/song.dart';
import 'package:provider/provider.dart';

class SongPages extends StatelessWidget {
  const SongPages({super.key});

String formatTime(Duration duration) {
  String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

  return formattedTime;
}

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSong>(
      builder: (context, value, child) {

        final playlist =value.Playlist;

        final currentSong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),

                    const Text("PL A Y L I S T"),

                    IconButton(onPressed: () {}, icon:const Icon(Icons.menu)),
                  ],
                ),

                const SizedBox(height: 25,),

                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: Image.asset(currentSong.albumArtImagePath, width: 250,),
                      ),

                       Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(currentSong.ArtistName,),
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
                          Text(formatTime(value.currentDuration)),
                          const Icon(Icons.shuffle),
                          const Icon(Icons.repeat),
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 0,
                        ),
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.yellow,
                        onChanged: (double double) {

                        },
                        onChangeEnd: (double double) {
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous)),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.PauseOrResume,
                        child:  NeuBox(child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: NeuBox(child: Icon(Icons.skip_next)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      }
    );
  }
}
