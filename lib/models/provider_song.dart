import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    
    Song(songName: "I wish I was Your Joke", ArtistName: "Reality Club", albumArtImagePath: "assets/images/i_wish_i_was.jpg", audioPath: "assets/mp3/i_wish.mp3",),

    Song(songName: "For lack Of A Better Word", ArtistName: "Reality Club", albumArtImagePath: "assets/images/ephi.jpg", audioPath: "love_ephi",)
  ];

  int? _currentSongIndex;

  List<Song> get Playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
}